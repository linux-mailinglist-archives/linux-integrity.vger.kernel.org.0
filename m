Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D6322199C
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 03:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGPBry (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 21:47:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58920 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbgGPBry (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 21:47:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G1WO69149272;
        Wed, 15 Jul 2020 21:47:52 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329d9jrajh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 21:47:51 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06G1bGjN000578;
        Thu, 16 Jul 2020 01:47:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 327527jjtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 01:47:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06G1llIn57213090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 01:47:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B439911C058;
        Thu, 16 Jul 2020 01:47:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14BBE11C054;
        Thu, 16 Jul 2020 01:47:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jul 2020 01:47:46 +0000 (GMT)
Message-ID: <1594864066.12900.356.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Check for tsspcrread in runtime
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Wed, 15 Jul 2020 21:47:46 -0400
In-Reply-To: <20200715132817.8529-1-pvorel@suse.cz>
References: <20200715132817.8529-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=946
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160005
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-15 at 15:28 +0200, Petr Vorel wrote:
> instead of checking in build time as it's runtime dependency.
> Also log when tsspcrread not found to make debugging easier.
> 
> We search for tsspcrread unless there is tss2-esys with Esys_PCR_Read(),
> thus pcr_none.c was dropped as unneeded.
> 
> file_exist(), tst_get_path() and MIN() taken from LTP project.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Mimi,
> 
> changes v1->v2:
> * Log used binary/library.
> * Drop using **errmsg in tpm2_pcr_supported() use log_info() and
> log_debug() instead.
> * Formatting changes in includes
> 
> Feel free to amend this patch to suit your needs.

log_info() is not displaying the method of reading the PCRs.  To
resolve this add the necessary USE_FPRINTF definitions.

Mimi
