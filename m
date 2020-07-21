Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75401227FF1
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jul 2020 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgGUMag (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jul 2020 08:30:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36769 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725984AbgGUMag (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jul 2020 08:30:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LC31on062319;
        Tue, 21 Jul 2020 08:30:33 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32dn6xjwnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 08:30:33 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LCG624001233;
        Tue, 21 Jul 2020 12:30:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 32brq7uyex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 12:30:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LCUSDd31392000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 12:30:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AB08A4065;
        Tue, 21 Jul 2020 12:30:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7200A4059;
        Tue, 21 Jul 2020 12:30:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.199.44])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jul 2020 12:30:27 +0000 (GMT)
Message-ID: <1595334627.5109.23.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Tue, 21 Jul 2020 08:30:27 -0400
In-Reply-To: <20200720150038.9082-2-James.Bottomley@HansenPartnership.com>
References: <20200720150038.9082-1-James.Bottomley@HansenPartnership.com>
         <20200720150038.9082-2-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_05:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210086
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

On Mon, 2020-07-20 at 08:00 -0700, James Bottomley wrote:
> use macro magic to create sysfs per hash groups with 24 PCR files in
> them one for each possible agile hash of the TPM.  The files are
> plugged in to a read function which is TPM version agnostic, so this
> works also for TPM 1.2 although the hash is only sha1 in that case.
> For every hash the TPM supports, a group named pcr-<hash> is created
> and each of the PCR read files placed under it.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Nice!  Being able to read the TPM 2.0 PCRs, without requiring a TSS,
will really simplify regression testing - re-calculating the IMA
"boot_aggregate" and verifying the IMA measurement list.

With the following code snippet all of the PCRs for all the exported
TPM banks are displayed, but unfortunately the digests are not ordered
or prefixed with the PCR.

banks=$(echo -n $(ls -d /sys/class/tpm/tpm0/pcr-*))

for bank in ${banks[@]}; do
        echo "$bank:"
        find "${bank}/" -type f -exec cat {} \;
        echo " "
done

Either this code snippet needs to be fixed or, perhaps, instead of
returning just the digest, the digest could be prefixed with the PCR
number (eg. PCR-00:<digest>).

FYI, with this patch on a system with TPM 1.2, IMA goes into TPM-
bypass mode.

From dmesg (with some extra debugging):
tpm_chip_register: tpm_add_legacy_sysfs failed
tpm_tis: probe of 00:05 failed with error -2

Mimi
