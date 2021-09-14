Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6432B40B2F6
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhINPZs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 11:25:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231816AbhINPZs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 11:25:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EF0T4f032035;
        Tue, 14 Sep 2021 11:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sA3U0gdsv3dyqTQnAyG0Fx91fbF6YZmZnsi17RyyFcE=;
 b=cTq8GSjBBz/nCIgdu00o476VSaodHpPuKQtJ5f6KLavTy8Fhd263KHPDSUNZWKebawNP
 IPFOeE5dR8xnrJXS88gwI3RK0lc04gU1XDXHiKrAcWw8s6/OSWF9wEyvd+pjT9UqR+Ai
 bsL5sHnqA/XByemIrAVJvZUR0kfJMQEhMrTML7/PoRYLJIQebcD3suaizepekQZ21mlT
 6ovZP2+NdGCB5/M500aoa/UgfPDRl2K/lD7V/b8cpo0d/W2IFWigOGNAUzQGvb0449YP
 ojjPlTYL2lXWVaTRTZ6WKkEszwlJc55jE0Af3/rOPKIew7Clo88IuPjYJCw0UHp8AMxi Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b2v8cm3cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 11:24:30 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18EDJJ6j016659;
        Tue, 14 Sep 2021 11:24:30 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b2v8cm3b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 11:24:29 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18EF2HZJ018946;
        Tue, 14 Sep 2021 15:24:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3b0m39vk94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 15:24:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18EFOOVj54460902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 15:24:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48F5011C054;
        Tue, 14 Sep 2021 15:24:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31C6511C05E;
        Tue, 14 Sep 2021 15:24:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.116.105])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Sep 2021 15:24:22 +0000 (GMT)
Message-ID: <0a8960c73cd7836949e891ac8efdf516907669cb.camel@linux.ibm.com>
Subject: Re: [PATCH v7 ima-evm-utils 1/2] set default hash algorithm in
 configuration time
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>, Simon.THOBY@viveris.fr,
        kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 14 Sep 2021 11:24:22 -0400
In-Reply-To: <20210910184701.386163-2-bmeneg@redhat.com>
References: <20210910184701.386163-1-bmeneg@redhat.com>
         <20210910184701.386163-2-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BXpPhNJK5ikNYtcMZeAYTotWqSAsDMgz
X-Proofpoint-ORIG-GUID: H1k3r9K4825OWurBcIJMFK3_6LUizIHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140070
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-09-10 at 15:47 -0300, Bruno Meneguele wrote:
> The default hash algorithm for evmctl is today hardcoded in the libimaevm.c
> file. To facilitate package maintainers across different distributions to
> set their own default hash algorithm this, patch adds the
> --with-default-hash=<algo> option to the configuration script.
> 
> The chosen algorithm will then be checked by its available in the kernel,
> otherwise IMA won't be able to verify files hashed by the user. For that,
> the kernel header hash_info.h used as the source of supported hashes. In
> case the hash_info.h header is not present, the configuration script warns
> about it, but uses whatever the user specified in the option.
> 
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>

Thanks, Bruno.  This patch set is now queued in the next-testing
branch.

Mimi

