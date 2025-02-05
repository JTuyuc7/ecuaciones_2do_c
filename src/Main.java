import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileReader;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;

public class Main {

    private JFrame frame;
    private JTextArea outputArea;
    private JButton loadButton;
    private File selectedFile;
    private List<String> validNumberes;

    public Main(){
        initialize();
    }

    private void initialize(){
        frame = new JFrame();
        frame.setTitle("Ecuaciones segundo grado");
        frame.setBounds(100, 100, 450, 500);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().setLayout(new BorderLayout());

        outputArea = new JTextArea();
        outputArea.setEditable(false);
        JScrollPane scrollPane = new JScrollPane(outputArea);
        frame.getContentPane().add(scrollPane, BorderLayout.CENTER);

        JPanel buttonPanel = new JPanel();
        frame.getContentPane().add(buttonPanel, BorderLayout.SOUTH);

        loadButton = new JButton("Seleccionar archivo");
        buttonPanel.add(loadButton);

        loadButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                selectFileToAnalize();
            }
        });


        frame.setVisible(true);
    }

    private void selectFileToAnalize(){
        JFileChooser fileChoosen = new JFileChooser();
        int opt = fileChoosen.showOpenDialog(frame);
        if(opt == JFileChooser.APPROVE_OPTION){
            selectedFile = fileChoosen.getSelectedFile();
            System.out.println(selectedFile.getAbsolutePath());
            System.out.println(selectedFile.getName());
            System.out.println(selectedFile);
            processData(selectedFile);
        }
    }

    private void processData(File file){
        try {
            EcuacionesLexer lexer = new EcuacionesLexer(new FileReader(file));
            String token;
            String regex = "^(?:[+-]?\\d+(?:\\.\\d+)?X\\^2)\\s*(?:[+-])\\s*(?:\\d+(?:\\.\\d+)?)?X\\s*(?:[+-])\\s*\\d+(?:\\.\\d+)?(?:\\s*=\\s*0)?$";
            Pattern pattern = Pattern.compile(regex);

            // Set para almacenar ecuaciones válidas y evitar duplicados
            Set<String> validEquations = new HashSet<>();
            List<List<String>> listaDeListas = List.of();

            while ((token = lexer.yylex()) != null){
                // Obtén la lista de listas generadas por el lexer
                listaDeListas = lexer.getListaDeListas();

            }

            for (List<String> lista : listaDeListas) {
                String joinedList = String.join("", lista);
                System.out.println("Procesando: " + joinedList);
                // Si la cadena cumple el patrón y aún no se ha añadido, se procesa
                if(pattern.matcher(joinedList).matches() && !validEquations.contains(joinedList)){
                    validEquations.add(joinedList);
                    System.out.println("Cadena válida: " + joinedList);
                    outputArea.append("Cadena válida " + joinedList + "\n");
                }
            }
        } catch (Exception e){
            System.out.println("Algo salió mal xD");
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new Main());

//        private static final String REGEX = "^[0-9]+(\\.[0-9]+)?E[+-]?[0-9]+$";
    }
}