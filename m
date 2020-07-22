Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FC6229728
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 13:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGVLId (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 07:08:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730099AbgGVLId (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 07:08:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MB2aLC109187;
        Wed, 22 Jul 2020 07:08:30 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vvpp17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 07:08:30 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06MB8JCs020148;
        Wed, 22 Jul 2020 11:08:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 32brbgtgn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 11:08:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06MB8QiH31719696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 11:08:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E3A0AE04D;
        Wed, 22 Jul 2020 11:08:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10E1CAE053;
        Wed, 22 Jul 2020 11:08:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.139.199])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jul 2020 11:08:25 +0000 (GMT)
Message-ID: <1595416105.5311.33.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] pcr_tss: Fix compilation for old
 compilers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Wed, 22 Jul 2020 07:08:25 -0400
In-Reply-To: <20200722105202.32507-1-pvorel@suse.cz>
References: <20200722105202.32507-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_04:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=868 malwarescore=0 clxscore=1015
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007220080
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-22 at 12:52 +0200, Petr Vorel wrote:
> pcr_tss.c: In function 'pcr_selections_match':
> pcr_tss.c:73:2: error: 'for' loop initial declarations are only allowed in C99 mode
>   for (int i = 0; i < a->count; i++) {
>   ^
> pcr_tss.c:73:2: note: use option -std=c99 or -std=gnu99 to compile your code
> pcr_tss.c:78:3: error: 'for' loop initial declarations are only allowed in C99 mode
>    for (int j = 0; j < a->pcrSelections[i].sizeofSelect; j++) {
>    ^
> 
> Fixes: 03f99ea ("ima-evm-utils: Add support for Intel TSS2 for PCR
> reading")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

thanks,

Mimi
