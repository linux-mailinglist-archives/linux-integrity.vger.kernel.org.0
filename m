Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0CD20A167
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405681AbgFYO4t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 10:56:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2314 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405638AbgFYO4s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 10:56:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PEWas2084447;
        Thu, 25 Jun 2020 10:56:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwyj4e81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 10:56:45 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PEX0rx086617;
        Thu, 25 Jun 2020 10:56:45 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwyj4e7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 10:56:45 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PEjcGY031517;
        Thu, 25 Jun 2020 14:56:44 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 31uurq81gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 14:56:44 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PEuhH848824676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 14:56:43 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABE8F112064;
        Thu, 25 Jun 2020 14:56:43 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CE32112061;
        Thu, 25 Jun 2020 14:56:43 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 14:56:43 +0000 (GMT)
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Subject: Enabling interrupts in QEMU TPM TIS
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <1ca3a53d-2b83-7522-5ce1-83d9cc2f207d@linux.ibm.com>
Date:   Thu, 25 Jun 2020 10:56:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_10:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=872 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250091
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello!

  I want to enable IRQs now in QEMU's TPM TIS device model and I need to 
work with the following patch to Linux TIS. I am wondering whether the 
changes there look reasonable to you? Windows works with the QEMU 
modifications as-is, so maybe it's a bug in the TIS code (which I had 
not run into before).


The point of the loop I need to introduce in the interrupt handler is 
that while the interrupt handler is running another interrupt may 
occur/be posted that then does NOT cause the interrupt handler to be 
invoked again but causes a stall, unless the loop is there.

The 'o' in the dmesg log indicates the original IRQ for which the 
handler was invoked. The interrupt values have the following meaning.

0x2: STS valid

0x4: locality changed

0x80: command ready

So the first 'looping entry' [in log below] indicates that a locality 
change interrupt occurred while the interrupt handler was running due to 
STS_valid + command ready. This sounds reasonable considering that we 
are frequently acquiring and releasing the locality. The loop then deals 
with the locality change interrupt and the interrupts then settle.

[  210.365129] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1, rev-id 1)
[  210.367124] looping: 0x4  (o: 0x82)
[  212.375045] looping: 0x80  (o: 0x2)
[  212.389218] looping: 0x4  (o: 0x82)
[  212.404161] looping: 0x80  (o: 0x2)
[  212.526427] looping: 0x4  (o: 0x82)
[  212.595488] looping: 0x4  (o: 0x82)
[  212.614357] looping: 0x80  (o: 0x2)

diff --git a/drivers/char/tpm/tpm_tis_core.c 
b/drivers/char/tpm/tpm_tis_core.c
index 65ab1b027949..f77544563fb1 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -704,7 +704,7 @@ static irqreturn_t tis_int_handler(int dummy, void 
*dev_id)
  {
      struct tpm_chip *chip = dev_id;
      struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-    u32 interrupt;
+    u32 interrupt, o;
      int i, rc;

      rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
@@ -715,6 +715,7 @@ static irqreturn_t tis_int_handler(int dummy, void 
*dev_id)
          return IRQ_NONE;

      priv->irq_tested = true;
+again:
      if (interrupt & TPM_INTF_DATA_AVAIL_INT)
          wake_up_interruptible(&priv->read_queue);
      if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
@@ -731,7 +732,12 @@ static irqreturn_t tis_int_handler(int dummy, void 
*dev_id)
      if (rc < 0)
          return IRQ_NONE;

+    o = interrupt;
      tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
+    if (interrupt != 0) {
+        printk("looping: 0x%x  (o: 0x%x)\n", interrupt, o);
+        goto again;
+    }
      return IRQ_HANDLED;
  }

@@ -1062,6 +1068,8 @@ int tpm_tis_core_init(struct device *dev, struct 
tpm_tis_data *priv, int irq,
              goto out_err;
          }

+        tpm_chip_start(chip);
+        chip->flags |= TPM_CHIP_FLAG_IRQ;
          if (irq) {
              tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
                           irq);
@@ -1074,6 +1082,7 @@ int tpm_tis_core_init(struct device *dev, struct 
tpm_tis_data *priv, int irq,
          } else {
              tpm_tis_probe_irq(chip, intmask);
          }
+        tpm_chip_stop(chip);
      }

      rc = tpm_chip_register(chip);
-- 
2.26.2

    Stefan

