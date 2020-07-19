Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD622520F
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Jul 2020 15:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgGSN5n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Jul 2020 09:57:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgGSN5m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Jul 2020 09:57:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06JDWiHa041586;
        Sun, 19 Jul 2020 09:57:39 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32cea094d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 09:57:39 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06JDpZ6e032719;
        Sun, 19 Jul 2020 13:57:38 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 32brbh1c7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 13:57:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06JDuCfr61079944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Jul 2020 13:56:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9418A5204F;
        Sun, 19 Jul 2020 13:57:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.54])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1FD2B52051;
        Sun, 19 Jul 2020 13:57:35 +0000 (GMT)
Message-ID: <1595167054.27397.72.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Add sanity check for file parameter of
 ima_boot_aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Sun, 19 Jul 2020 09:57:34 -0400
In-Reply-To: <20200717120422.71299-1-pvorel@suse.cz>
References: <20200717120422.71299-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-19_02:2020-07-17,2020-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007190102
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-07-17 at 14:04 +0200, Petr Vorel wrote:
> Parameter expects to be a copy of
> /sys/kernel/security/tpm0/binary_bios_measurements (i.e. regular file,
> not a directory, block or character device, socket, ...)
> 
> Fixes: f49e982 ("ima-evm-utils: read the TPM 1.2 binary_bios_measurements")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Mimi,
> 
> feel free to modify this patchset to fits your needs (unless I'm wrong
> and this should not be applied at all).
> 

Thanks!  I made minor changes as noted below.  A subsequent patch
makes a similar change for the new TPM 1.2 PCRs.

> 
>  src/evmctl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 04dc2ad..3ad5039 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2082,6 +2082,13 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
>  	int len;
>  	int i;
> 
> +	struct stat s;
> +	stat(file, &s);

Checked stat return code.


> +	if (!S_ISREG(s.st_mode)) {
> +		log_errno("Not a regular file or link to regular file.\n");

Prefixed message with "Bios event log: not ..."

> +		return 1;
> +	}
> +
>  	fp = fopen(file, "r");
>  	if (!fp) {
>  		log_errno("Failed to open TPM 1.2 event log.\n");

