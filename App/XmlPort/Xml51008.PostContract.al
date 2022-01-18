xmlport 51008 "Post Contract"
{
    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/x51008';
    Direction = Both;
    Encoding = UTF8;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Contracts)
        {
            tableelement(IntCRMBuffer1; "Integration CRM Buffer 1")
            {
                MinOccurs = Zero;
                XmlName = 'IntCRMBuffer1';
                fieldelement(ICRMB_Unidad_de_negocio; IntCRMBuffer1."Unidad de negocio") { }
                fieldelement(ICRMB_Propuesta; IntCRMBuffer1."Propuesta") { }
                fieldelement(ICRMB_Oportunidad; IntCRMBuffer1."Oportunidad") { }
                fieldelement(ICRMB_Cliente; IntCRMBuffer1."Cliente") { }
                fieldelement(ICRMB_Tipo_de_cliente; IntCRMBuffer1."Tipo de cliente") { }
                fieldelement(ICRMB_Tipo_de_documento_DP; IntCRMBuffer1."Tipo de documento DP") { }
                fieldelement(ICRMB_Nro__Documento_1; IntCRMBuffer1."Nro. Documento 1") { }
                fieldelement(ICRMB_Producto; IntCRMBuffer1."Producto") { }
                fieldelement(ICRMB_Modelo_documeento; IntCRMBuffer1."Modelo documeento") { }
                fieldelement(ICRMB_Contrato_principal; IntCRMBuffer1."Contrato principal") { }
                fieldelement(ICRMB_Moneda_1; IntCRMBuffer1."Moneda_1") { }
                fieldelement(ICRMB_Penalidad_Res__Contrato___; IntCRMBuffer1."Penalidad Res. Contrato(%)") { }
                fieldelement(ICRMB_Responsable_Propietario; IntCRMBuffer1."Responsable Propietario") { }
                fieldelement(ICRMB_Nombre; IntCRMBuffer1."Nombre") { }
                fieldelement(ICRMB_Fecha_inicio_contrato; IntCRMBuffer1."Fecha inicio contrato") { }
                fieldelement(ICRMB_Fecha_fin_contrato; IntCRMBuffer1."Fecha fin contrato") { }
                fieldelement(ICRMB_Fecha_inicio_real_contrato; IntCRMBuffer1."Fecha inicio real contrato") { }
                fieldelement(ICRMB_Fecha_fin_real_contrato; IntCRMBuffer1."Fecha fin real contrato") { }
                fieldelement(ICRMB_Fecha_de_firma_contrato; IntCRMBuffer1."Fecha de firma contrato") { }
                fieldelement(ICRMB_Fecha_de_revision; IntCRMBuffer1."Fecha de revisión") { }
                fieldelement(ICRMB_Fec__Resolucion_observaciones; IntCRMBuffer1."Fec. Resolución observaciones") { }
                fieldelement(ICRMB_Fecha_de_envio_de_contrato; IntCRMBuffer1."Fecha de envío de contrato") { }
                fieldelement(ICRMB_Tipo_de_documento_IF; IntCRMBuffer1."Tipo de documento IF") { }
                fieldelement(ICRMB_Nro__documento; IntCRMBuffer1."Nro. documento") { }
                fieldelement(ICRMB_Direccion_IC; IntCRMBuffer1."Dirección IC") { }
                fieldelement(ICRMB_Pais; IntCRMBuffer1."País") { }
                fieldelement(ICRMB_Departamento___Region; IntCRMBuffer1."Departamento / Región") { }
                fieldelement(ICRMB_Provincia; IntCRMBuffer1."Provincia") { }
                fieldelement(ICRMB_Distrito___Comuna; IntCRMBuffer1."Distrito / Comuna") { }
                fieldelement(ICRMB_Representante_Atria__1_; IntCRMBuffer1."Representante Atria (1)") { }
                fieldelement(ICRMB_Representante_Atria__2_; IntCRMBuffer1."Representante Atria (2)") { }
                fieldelement(ICRMB_Representante_cliente__1_; IntCRMBuffer1."Representante cliente (1)") { }
                fieldelement(ICRMB_Cargo_RL_1; IntCRMBuffer1."Cargo RL 1") { }
                fieldelement(ICRMB_Direccion_RL_; IntCRMBuffer1."Dirección RL ") { }
                fieldelement(ICRMB_Correo_Electronico_RL; IntCRMBuffer1."Correo Electrónico RL") { }
                fieldelement(ICRMB_telefono_celular_RL; IntCRMBuffer1."teléfono celular RL") { }
                fieldelement(ICRMB_Representante_cliente__2_; IntCRMBuffer1."Representante cliente (2)") { }
                fieldelement(ICRMB_Cargo; IntCRMBuffer1."Cargo") { }
                fieldelement(ICRMB_Direccion; IntCRMBuffer1."Dirección") { }
                fieldelement(ICRMB_Correo_Electronico; IntCRMBuffer1."Correo Electrónico") { }
                fieldelement(ICRMB_telefono_celular; IntCRMBuffer1."teléfono celular") { }
                fieldelement(ICRMB_Nro__Partida; IntCRMBuffer1."Nro. Partida") { }
                fieldelement(ICRMB_Fecha_escritura_publica; IntCRMBuffer1."Fecha escritura pública") { }
                fieldelement(ICRMB_Notaria_escritura_publica; IntCRMBuffer1."Notaria escritura pública") { }
                fieldelement(ICRMB_Ciudad_escritura_publica; IntCRMBuffer1."Ciudad escritura pública") { }
                fieldelement(ICRMB_Aval_cliente__1_; IntCRMBuffer1."Aval cliente (1)") { }
                fieldelement(ICRMB_Aval_cliente__2_; IntCRMBuffer1."Aval cliente (2)") { }
                fieldelement(ICRMB_Aval_cliente__3_; IntCRMBuffer1."Aval cliente (3)") { }
                fieldelement(ICRMB_Aval_cliente__4_; IntCRMBuffer1."Aval cliente (4)") { }
                fieldelement(ICRMB_Es_una_migracion; IntCRMBuffer1."Es una migración") { }
                fieldelement(ICRMB_Realizo_enc__6m_despues_inic_; IntCRMBuffer1."Realizo enc. 6m despues inic.") { }
                fieldelement(ICRMB_Renovacion_automatica; IntCRMBuffer1."Renovación automática") { }
                fieldelement(ICRMB_Nro__de_años_a_renovar; IntCRMBuffer1."Nro. de años a renovar") { }
                fieldelement(ICRMB_Plazo_solicitud_no_renov___m_; IntCRMBuffer1."Plazo solicitud no renov. (m)") { }
                fieldelement(ICRMB_Derecho_preferente; IntCRMBuffer1."Derecho preferente") { }
                fieldelement(ICRMB_Plazo_sol__Nvas_cotizaciones; IntCRMBuffer1."Plazo sol. Nvas cotizaciones") { }
                fieldelement(ICRMB_Cantidad_de_cot__solicitadas; IntCRMBuffer1."Cantidad de cot. solicitadas") { }
                fieldelement(ICRMB_Plazo_inf__mejor_oferta_rec_D_; IntCRMBuffer1."Plazo inf. mejor oferta rec(D)") { }
                fieldelement(ICRMB_Plazo_inf__decisionDer_Pref_D_; IntCRMBuffer1."Plazo inf. decisiónDer.Pref(D)") { }
                fieldelement(ICRMB_Plazo_sol__aumentoPot_Ene__M_; IntCRMBuffer1."Plazo sol. aumentoPot/Ene.(M)") { }
                fieldelement(ICRMB_Plz__R__solic__aumentoPot_EneD; IntCRMBuffer1."Plz. R. solic. aumentoPot/EneD") { }
                fieldelement(ICRMB_Plazo_de_emision_de_factura_D_; IntCRMBuffer1."Plazo de emisión de factura(D)") { }
                fieldelement(ICRMB_Plazo_de_pago__Dias_; IntCRMBuffer1."Plazo de pago (Días)") { }
                fieldelement(ICRMB_Plz__Pago_ent__fact__texto__CI; IntCRMBuffer1."Plz. Pago ent. fact (texto)-CI") { }
                fieldelement(ICRMB_Plz__Corte_No_pago_fact__Dias_; IntCRMBuffer1."Plz. Corte No pago fact.(Días)") { }
                fieldelement(ICRMB_Plz_Peri__NoPagos_prev__Resol_; IntCRMBuffer1."Plz.Peri. NoPagos prev. Resol.") { }
                fieldelement(ICRMB_Plz__Incumpli__Gen__Resol___D_; IntCRMBuffer1."Plz. Incumpli. Gen. Resol. (D)") { }
                fieldelement(ICRMB_Margen_real__USS_MWh_; IntCRMBuffer1."Margen real (US$/MWh)") { }
                fieldelement(ICRMB_Contrato_Atria_S; IntCRMBuffer1."Contrato Atria S") { }
                fieldelement(ICRMB_Suministro; IntCRMBuffer1."Suministro") { }
                fieldelement(ICRMB_Nombre_suministro; IntCRMBuffer1."Nombre suministro") { }
                fieldelement(ICRMB_Direccion_concatenada; IntCRMBuffer1."Dirección concatenada") { }
                fieldelement(ICRMB_Distribuidora_S; IntCRMBuffer1."Distribuidora S") { }
                fieldelement(ICRMB_Punto_suministro; IntCRMBuffer1."Punto suministro") { }
                fieldelement(ICRMB_Barra_de_Referencia; IntCRMBuffer1."Barra de Referencia") { }
                fieldelement(ICRMB_Propietario_S; IntCRMBuffer1."Propietario S") { }
                fieldelement(ICRMB_Moneda_S; IntCRMBuffer1."Moneda S") { }
                fieldelement(ICRMB_Fecha_de_inicio__contrato_; IntCRMBuffer1."Fecha de inicio (contrato)") { }
                fieldelement(ICRMB_Fecha_de_fin__contrato_; IntCRMBuffer1."Fecha de fin (contrato)") { }
                fieldelement(ICRMB_Fecha_de_migracion; IntCRMBuffer1."Fecha de migración") { }
                fieldelement(ICRMB_Exceso_potencia____; IntCRMBuffer1."Exceso potencia (%)") { }
                fieldelement(ICRMB_Exceso_energia____; IntCRMBuffer1."Exceso energía (%)") { }
                fieldelement(ICRMB_Potencia_Min__Facturable_kW___; IntCRMBuffer1."Potencia Mín. Facturable kW(%)") { }
                fieldelement(ICRMB_Potencia_Min__Fact__kW__Monto_; IntCRMBuffer1."Potencia Min. Fact. kW (Monto)") { }
                fieldelement(ICRMB_Potencia_Estacional; IntCRMBuffer1."Potencia Estacional") { }
                fieldelement(ICRMB_Precio_Escalonado; IntCRMBuffer1."Precio Escalonado") { }
                fieldelement(ICRMB_Fecha_de_carta_pre_aviso; IntCRMBuffer1."Fecha de carta pre aviso") { }
                fieldelement(ICRMB_Fecha_de_carta_distribuidora; IntCRMBuffer1."Fecha de carta distribuidora") { }
                fieldelement(ICRMB_CorrelativoCarta_distribuidora; IntCRMBuffer1."CorrelativoCarta distribuidora") { }
                fieldelement(ICRMB_Max__PC___HP__kW_; IntCRMBuffer1."Max. PC - HP (kW)") { }
                fieldelement(ICRMB_Max__PC___HFP__kW_; IntCRMBuffer1."Max. PC - HFP (kW)") { }
                fieldelement(ICRMB_Mes; IntCRMBuffer1."Mes") { }
                fieldelement(ICRMB_Potencia_Contratada_HP__kW_; IntCRMBuffer1."Potencia Contratada HP (kW)") { }
                fieldelement(ICRMB_Potencia_Contratada_HFP__kW_; IntCRMBuffer1."Potencia Contratada HFP (kW)") { }
                fieldelement(ICRMB_Fecha_de_inicio_P; IntCRMBuffer1."Fecha de inicio P") { }
                fieldelement(ICRMB_Fecha_de_fin_P; IntCRMBuffer1."Fecha de fin P") { }
                fieldelement(ICRMB_Moneda_Precio_energia_HP_y_HFP; IntCRMBuffer1."Moneda Precio energia HP y HFP") { }
                fieldelement(ICRMB_Tipo_de_cambio; IntCRMBuffer1."Tipo de cambio") { }
                fieldelement(ICRMB_Precio_energia_HP_HFP_USS_MWh_; IntCRMBuffer1."Precio energía HP/HFP(US$/MWh)") { }
                fieldelement(ICRMB_Prec_energia_HP_HFP_O_Mon_kWh_; IntCRMBuffer1."Prec energía HP/HFP(O-Mon/kWh)") { }
                fieldelement(ICRMB_Contrato_Atria; IntCRMBuffer1."Contrato Atria") { }
                fieldelement(ICRMB_Moneda; IntCRMBuffer1."Moneda") { }
                fieldelement(ICRMB_Propietario; IntCRMBuffer1."Propietario") { }
                fieldelement(ICRMB_Energia_HP_Index; IntCRMBuffer1."Energía HP Index") { }
                fieldelement(ICRMB_Valor_Index_Energia_HP___PP; IntCRMBuffer1."Valor Index Energía HP - PP") { }
                fieldelement(ICRMB_Mes_Vigencia; IntCRMBuffer1."Mes Vigencia") { }
                fieldelement(ICRMB_Año_vigencia; IntCRMBuffer1."Año vigencia") { }
                fieldelement(ICRMB_Energia_HFP_Index; IntCRMBuffer1."Energía HFP Index") { }
                fieldelement(ICRMB_Valor_Index_Energia_HFP___PP; IntCRMBuffer1."Valor Index Energía HFP - PP") { }
                fieldelement(ICRMB_Potencia_Index; IntCRMBuffer1."Potencia Index") { }
                fieldelement(ICRMB_Valor_Index_Potencia___PP; IntCRMBuffer1."Valor Index Potencia - PP") { }
                fieldelement(ICRMB_Importe_financiamiento_G; IntCRMBuffer1."Importe financiamiento G") { }
                fieldelement(ICRMB_Importe_financiamiento_LetrasG; IntCRMBuffer1."Importe financiamiento LetrasG") { }
                fieldelement(ICRMB_Concepto_del_prestamo_G; IntCRMBuffer1."Concepto del préstamo G") { }
                fieldelement(ICRMB_Contrato_relacionado_PPA_CR; IntCRMBuffer1."Contrato relacionado PPA CR") { }
                fieldelement(ICRMB_Fecha_inicio_contrato_rel__CR; IntCRMBuffer1."Fecha inicio contrato rel. CR") { }
                fieldelement(ICRMB_Fecha_de_fin_contrato_rel__CR; IntCRMBuffer1."Fecha de fin contrato rel. CR") { }
                fieldelement(ICRMB_Banco_del_cliente_DBC_1; IntCRMBuffer1."Banco del cliente DBC 1") { }
                fieldelement(ICRMB_Tipo_cuenta_bancaria_DBC_1; IntCRMBuffer1."Tipo cuenta bancaria DBC 1") { }
                fieldelement(ICRMB_Nro__cuenta_banc_cliente_DBC_1; IntCRMBuffer1."Nro. cuenta banc.cliente DBC 1") { }
                fieldelement(ICRMB_CCI_DBC_1; IntCRMBuffer1."CCI DBC 1") { }
                fieldelement(ICRMB_Nro__cuenta_detraccion_DBC_1; IntCRMBuffer1."Nro. cuenta detracción DBC 1") { }
                fieldelement(ICRMB_Fecha_de_inicio; IntCRMBuffer1."Fecha de inicio") { }
                fieldelement(ICRMB_Fecha_de_fin; IntCRMBuffer1."Fecha de fin") { }
                fieldelement(ICRMB_Energia_minima_esperada_MWh; IntCRMBuffer1."Energía mínima esperada MWh") { }
                fieldelement(ICRMB_Fecha_Inicio_Repago_DLL; IntCRMBuffer1."Fecha Inicio Repago DLL") { }
                fieldelement(ICRMB_Consumo_minimo_anual__MWh_; IntCRMBuffer1."Consumo mínimo anual (MWh)") { }
                fieldelement(ICRMB_potencia_contratada_anual_MWh_; IntCRMBuffer1."potencia contratada anual(MWh)") { }
                fieldelement(ICRMB_Fecha_Analisis_cons__energia; IntCRMBuffer1."Fecha Análisis cons. energía") { }
                fieldelement(ICRMB_Fec_Ini_Ult__peri__energia_min; IntCRMBuffer1."Fec.Ini.Últ. peri. energía mín") { }
                fieldelement(ICRMB_Fec_fin_ult_peri__energia_min_; IntCRMBuffer1."Fec.fin.últ.peri. energía mín.") { }
                fieldelement(ICRMB_Ejec__negocios_financieros_1; IntCRMBuffer1."Ejec. negocios financieros 1") { }
                fieldelement(ICRMB_Cons_Total_Energia_espe___MWh_; IntCRMBuffer1."Cons.Total Energía espe. (MWh)") { }
                fieldelement(ICRMB_Max__energia_min__espe___MWh_; IntCRMBuffer1."Máx. energía mín. espe. (MWh)") { }
                fieldelement(ICRMB_Cons_Ene_min__ult__Peri___MWh_; IntCRMBuffer1."Cons.Ene.mín. últ. Peri. (MWh)") { }
                fieldelement(ICRMB_Ejec__negocios_financieros_2; IntCRMBuffer1."Ejec. negocios financieros 2") { }
                fieldelement(ICRMB_Precio_energia_USS_MWh__Letras; IntCRMBuffer1."Precio energía(US$/MWh) Letras") { }
                fieldelement(ICRMB_Ejec__negocios_financieros_3; IntCRMBuffer1."Ejec. negocios financieros 3") { }
                fieldelement(ICRMB_Importe_financiamiento; IntCRMBuffer1."Importe financiamiento") { }
                fieldelement(ICRMB_Importe_financiamiento_letras; IntCRMBuffer1."Importe financiamiento letras") { }
                fieldelement(ICRMB_Concepto_del_prestamo_G2; IntCRMBuffer1."Concepto del préstamo G2") { }
                fieldelement(ICRMB_Contrato_relacionado_PPA; IntCRMBuffer1."Contrato relacionado PPA") { }
                fieldelement(ICRMB_Fecha_de_inicio_contrato_rel_; IntCRMBuffer1."Fecha de inicio contrato rel.") { }
                fieldelement(ICRMB_Fecha_de_fin_contrato_rel_; IntCRMBuffer1."Fecha de fin contrato rel.") { }
                fieldelement(ICRMB_Banco_del_cliente_DBC_2; IntCRMBuffer1."Banco del cliente DBC 2") { }
                fieldelement(ICRMB_Tipo_cuenta_bancaria_DBC_2; IntCRMBuffer1."Tipo cuenta bancaria DBC 2") { }
                fieldelement(ICRMB_Nro__cuenta_banc_cliente_DBC_2; IntCRMBuffer1."Nro. cuenta banc.cliente DBC 2") { }
                fieldelement(ICRMB_CCI_DBC_2; IntCRMBuffer1."CCI DBC 2") { }
                fieldelement(ICRMB_Nro__cuenta_detraccion_DBC_2; IntCRMBuffer1."Nro. cuenta detracción DBC 2") { }
                fieldelement(ICRMB_Monto_Cuota; IntCRMBuffer1."Monto Cuota") { }
                fieldelement(ICRMB_Monto_Cuota_en_letras; IntCRMBuffer1."Monto Cuota en letras") { }
                fieldelement(ICRMB_Numero_cuotas_financiamiento; IntCRMBuffer1."Número cuotas financiamiento") { }
                fieldelement(ICRMB_Numero_cuotas_finan___letras_; IntCRMBuffer1."Número cuotas finan. (letras)") { }
                fieldelement(ICRMB_Tasa__anual____; IntCRMBuffer1."Tasa  anual (%)") { }
                fieldelement(ICRMB_Tasa_nominal_anual____; IntCRMBuffer1."Tasa nominal anual (%)") { }
                fieldelement(ICRMB_Tasa_efectiva_anual____; IntCRMBuffer1."Tasa efectiva anual (%)") { }
                fieldelement(ICRMB_Tasa_efectiva_anual_en_letras; IntCRMBuffer1."Tasa efectiva anual en letras") { }
                fieldelement(ICRMB_Tasa_moratoria____; IntCRMBuffer1."Tasa moratoria (%)") { }
                fieldelement(ICRMB_Fecha_deuda_distribuidora; IntCRMBuffer1."Fecha deuda distribuidora") { }
                fieldelement(ICRMB_Distribuidora_G; IntCRMBuffer1."Distribuidora G") { }
                fieldelement(ICRMB_Fecha_de_emision_pagare; IntCRMBuffer1."Fecha de emisión pagare") { }
                fieldelement(ICRMB_Dia_de_pago; IntCRMBuffer1."Día de pago") { }
                fieldelement(ICRMB_Fecha_primera_cuota_de_pago; IntCRMBuffer1."Fecha primera cuota de pago") { }
                fieldelement(ICRMB_Fecha_ultima_cuota_de_pago; IntCRMBuffer1."Fecha última cuota de pago") { }
                fieldelement(ICRMB_Ejec__negocios_financieros_G; IntCRMBuffer1."Ejec. negocios financieros G") { }
                fieldelement(ICRMB_Nro__de_cuota; IntCRMBuffer1."Nro. de cuota") { }
                fieldelement(ICRMB_Saldo; IntCRMBuffer1."Saldo") { }
                fieldelement(ICRMB_Capital; IntCRMBuffer1."Capital") { }
                fieldelement(ICRMB_Intereses; IntCRMBuffer1."Intereses") { }
                fieldelement(ICRMB_Cuota; IntCRMBuffer1."Cuota") { }
                fieldelement(ICRMB_Dias; IntCRMBuffer1."Días") { }
                fieldelement(ICRMB_Fecha_de_pago; IntCRMBuffer1."Fecha de pago") { }
                fieldelement(ICRMB_IGV_Intereses; IntCRMBuffer1."IGV Intereses") { }
                fieldelement(ICRMB_Cuota_con_IGV; IntCRMBuffer1."Cuota con IGV") { }
            }
        }
    }

    var
        myInt: Integer;
}