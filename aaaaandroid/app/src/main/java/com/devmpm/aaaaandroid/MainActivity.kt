package com.devmpm.aaaaandroid

import android.content.Context
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()//Activa opción de rotado para cubirir de borde a borde
        setContentView(R.layout.activity_main)//Accede a un .xml y arma la interfaz. R permite acceder a la carpeta res
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        val etCorreo = findViewById<EditText>(R.id.edtCorreo)
        val btn1 = findViewById<Button>(R.id.btn1)
        val correo = etCorreo.text.toString()
        setOnClickListener(btn1) {
            Toast.makeText(this, correo, Toast.LENGTH_SHORT).show()
        }
    }
    override fun onPause()
    {
        super.onPause()

    }
}