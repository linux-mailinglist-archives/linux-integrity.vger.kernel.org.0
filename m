Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424A78AD29
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 05:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfHMDjc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Aug 2019 23:39:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726500AbfHMDjc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Aug 2019 23:39:32 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7D3bL76048481;
        Mon, 12 Aug 2019 23:39:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubj8d5yrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 23:39:29 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7D3c9M6050896;
        Mon, 12 Aug 2019 23:39:29 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubj8d5yr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 23:39:29 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7D3YQRx021135;
        Tue, 13 Aug 2019 03:39:28 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 2u9nj62x65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 03:39:28 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7D3dRLO48693522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 03:39:27 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ACA52805A;
        Tue, 13 Aug 2019 03:39:27 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BC6D28058;
        Tue, 13 Aug 2019 03:39:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Aug 2019 03:39:27 +0000 (GMT)
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Subject: Does probing of TIS with interrupts work
Message-ID: <f721bf34-1cfc-de2b-91e4-24b17150645b@linux.ibm.com>
Date:   Mon, 12 Aug 2019 23:39:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=868 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130037
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I have tried to get probing of TIS with interrupts to work on a module 
and I am wondering whether it works for anyone. I noticed it tries to 
probe while locality 0 is released and the TPM_CHIP_FLAG_IRQ is never 
set, so it never gets to certain places in the code. To get it to work I 
had to add a patch like this one here to tpm_tis_core_init:

@ -981,11 +1023,16 @@ int tpm_tis_core_init(struct device *dev, struct 
tpm_tis_data *priv, int irq,
                 }

                 if (irq) {
+                       tpm_chip_start(chip);
+                       printk(KERN_INFO "%s %d: chip->flags & 
TPM_CHIP_FLAG_IRQ = %x\n",
+                            __func__, __LINE__, chip->flags & 
TPM_CHIP_FLAG_IRQ);
+                       chip->flags |= TPM_CHIP_FLAG_IRQ;
                         tpm_tis_probe_irq_single(chip, intmask, 
IRQF_SHARED,
                                                  irq);
                         if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
                                 dev_err(&chip->dev, FW_BUG
                                         "TPM interrupt not working, 
polling instead\n");
+                       tpm_chip_stop(chip);
                 } else {
                         tpm_tis_probe_irq(chip, intmask);
                 }


Can this be right ?

    Stefan

