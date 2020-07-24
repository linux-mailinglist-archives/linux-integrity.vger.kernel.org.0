Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B08A22CED1
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 21:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGXToY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 15:44:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgGXToY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 15:44:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OJUdN7077206
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 15:44:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32g5d1h1mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 15:44:23 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06OJVcuY079581
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 15:44:23 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32g5d1h1kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 15:44:23 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06OJUHF6022694;
        Fri, 24 Jul 2020 19:44:21 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 32brq847qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 19:44:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06OJiJn956098936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 19:44:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DF6742041;
        Fri, 24 Jul 2020 19:44:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C058E4203F;
        Fri, 24 Jul 2020 19:44:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.236.7])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jul 2020 19:44:18 +0000 (GMT)
Message-ID: <1595619858.5017.39.camel@linux.ibm.com>
Subject: Re: [PATCH v3 ima-evm-utils] extend ima_measurement --pcrs option
 to support per-bank pcr files
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     linux-integrity@vger.kernel.org, bill.c.roberts@gmail.com
Date:   Fri, 24 Jul 2020 15:44:18 -0400
In-Reply-To: <1595617967.5017.31.camel@linux.ibm.com>
References: <20200724145242.31178-1-stephen.smalley.work@gmail.com>
         <1595617967.5017.31.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_08:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-07-24 at 15:12 -0400, Mimi Zohar wrote:
> On Fri, 2020-07-24 at 10:52 -0400, Stephen Smalley wrote:
> > Extend the ima_measurement --pcrs option to support per-bank pcr files.
> > The extended syntax is "--pcrs algorithm,pathname".  If no algorithm
> > is specified, it defaults to sha1 as before.  Multiple --pcrs options
> > are now supported, one per bank of PCRs. The file format remains
> > unchanged.  If --pcrs is specified, only try to read PCRs from the
> > specified file(s); do not fall back to trying to read from sysfs
> > or the TPM itself in this case since the user requested use of
> > the files.
> > 
> > Create per-bank pcr files, depends on "tpm: add sysfs exports for all
> > banks of PCR registers" kernel patch:
> > $ cat tpm2pcrread.sh
> > #!/bin/sh
> > for alg in sha1 sha256
> > do
> >   rm -f pcr-$alg
> >   pcr=0;
> >   while [ $pcr -lt 24 ];
> >   do
> >     printf "PCR-%02d: " $pcr >> pcr-$alg;
> >     cat /sys/class/tpm/tpm0/pcr-$alg/$pcr >> pcr-$alg;
> >     pcr=$[$pcr+1];
> >   done
> > done
> > $ sh ./tpm2pcrread.sh
> > 
> > Pass only the sha1 PCRs to evmctl defaulting to sha1:
> > $ sudo evmctl ima_measurement --pcrs pcr-sha1 /sys/kernel/security/integrity/ima/binary_runtime_measurements
> > 
> > Pass only the sha1 PCRs to evmctl with explicit selection of sha1:
> > $ sudo evmctl ima_measurement --pcrs sha1,pcr-sha1 /sys/kernel/security/integrity/ima/binary_runtime_measurements
> > 
> > Pass both sha1 and sha256 PCRs to evmctl:
> > $ sudo evmctl ima_measurement --pcrs sha1,pcr-sha1 --pcrs sha256,pcr-sha256 /sys/kernel/security/integrity/ima/binary_runtime_measurements
> > 
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> 
> I reviewed the patch and everything looks good, other than a few
> comments below.  Weirdly the order in which the TPM bank files
> containing the PCRs are supplied on the command line is affecting
> being able to verify the measurement list - sha1, sha256 versus
> sha256, sha1.  Perhaps during the time it takes to read the different
> banks, the PCRs have changed?  Not quite sure what is happening.

Never mind, problem solved.

Mimi
