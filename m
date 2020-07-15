Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9ED22156A
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 21:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgGOTr4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 15:47:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727948AbgGOTr4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 15:47:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FJWlsT140115;
        Wed, 15 Jul 2020 15:47:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329apxy774-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 15:47:53 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FJWtHC140906;
        Wed, 15 Jul 2020 15:47:53 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329apxy76d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 15:47:53 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FJk8bT009340;
        Wed, 15 Jul 2020 19:47:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 327527jeu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 19:47:51 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FJln2m57737412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 19:47:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61A6552051;
        Wed, 15 Jul 2020 19:47:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D3D345204E;
        Wed, 15 Jul 2020 19:47:48 +0000 (GMT)
Message-ID: <1594842468.12900.339.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/8] ima_evm_utils: support extending TPM 2.0 banks
 w/original SHA1 padded digest
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Date:   Wed, 15 Jul 2020 15:47:48 -0400
In-Reply-To: <20200715184327.GH3720@glitch>
References: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
         <1594396859-9232-3-git-send-email-zohar@linux.ibm.com>
         <20200715184327.GH3720@glitch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Bruno,

On Wed, 2020-07-15 at 15:43 -0300, Bruno Meneguele wrote:
<snip>

If this patch was in next-testing, I could simply update it.  Please
send a new patch to remove fox.

thanks,

Mimi

> 'fox' is not being used in the code anymore. It could be totally removed
> afaics.
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 90a3eeb..ae513b0 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1425,7 +1425,6 @@ struct template_entry {
>  };
> 
>  static uint8_t zero[MAX_DIGEST_SIZE];
> -static uint8_t fox[MAX_DIGEST_SIZE];
> 
>  static int validate = 0;
>  static int verify = 0;
> @@ -1886,7 +1885,6 @@ static int ima_measurement(const char *file)
> 
>         errno = 0;
>         memset(zero, 0, MAX_DIGEST_SIZE);
> -       memset(fox, 0xff, MAX_DIGEST_SIZE);
> 
>         pseudo_padded_banks = init_tpm_banks(&num_banks);
>         pseudo_banks = init_tpm_banks(&num_banks);
> 
> 

