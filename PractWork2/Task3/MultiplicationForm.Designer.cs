namespace Task3
{
    partial class MultiplicationForm
    {
        /// <summary>
        /// Обязательная переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.multTable = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // multTable
            // 
            this.multTable.Location = new System.Drawing.Point(12, 12);
            this.multTable.Name = "multTable";
            this.multTable.Size = new System.Drawing.Size(776, 300);
            this.multTable.TabIndex = 0;
            this.multTable.UseVisualStyleBackColor = true;
            this.multTable.Click += new System.EventHandler(this.multTable_Click);
            // 
            // MultiplicationForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.multTable);
            this.Name = "MultiplicationForm";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button multTable;
    }
}

