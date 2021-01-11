Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A032F1606
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Jan 2021 14:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbhAKNro (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Jan 2021 08:47:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387573AbhAKNrn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jan 2021 08:47:43 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10BDknDm144977;
        Mon, 11 Jan 2021 08:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pndz/Z80vqMHUBLIj5CZ6gUYG29beKH5GXEQU02RA9w=;
 b=NHr6FeZcAib4+IezLZWu6kCvq8329gbUplF5EWkKESNegjuwgLGB3PpyEAtBuc5HHino
 5RFOKF3uM/d+B/zIauQbPMpXILzKmg6FiuytFm6GKTsLVfXXmnq7m5XpcdbA57ttZjyq
 eLvDFTf/jLy+Y9AXlwbPsAVeJpnAEKijj4mj1aZ2BsorXqHa6swnLpRUiQ4aIiKm8ly/
 auPLc9oQiOFDdUqhWrm942sC/tX6dQDYl2VGa16gXXhpxGUJ8H9aIZVWaPR8a5R6YTt0
 cf9ibW1wg6ScmX0a9yNg1NkgrUHTHPemnLBXXRtoIy6xM2LEGBoLNsnvjyLzOob263y7 IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 360qv0801m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 08:46:49 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10BDkmYP144929;
        Mon, 11 Jan 2021 08:46:48 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 360qv08012-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 08:46:48 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10BDgHIA032091;
        Mon, 11 Jan 2021 13:46:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 35ydrd9xeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 13:46:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10BDkh9250725254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 13:46:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB02D42045;
        Mon, 11 Jan 2021 13:46:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4B524204C;
        Mon, 11 Jan 2021 13:46:41 +0000 (GMT)
Received: from sig-9-65-221-171.ibm.com (unknown [9.65.221.171])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jan 2021 13:46:41 +0000 (GMT)
Message-ID: <31aed9f12482d1156c224c2cc5ac8afd81e8cb14.camel@linux.ibm.com>
Subject: Re: [PATCH v2] evm: Fix memory leak in init_desc
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@nokia.com>,
        James Morris <jmorris@namei.org>, Kangjie Lu <kjlu@umn.edu>,
        "Serge E. Hallyn" <serge@hallyn.com>
Date:   Mon, 11 Jan 2021 08:46:40 -0500
In-Reply-To: <7288d0ce-e900-d942-fb6b-eabb63649591@web.de>
References: <20210110080253.32345-1-dinghao.liu@zju.edu.cn>
         <7288d0ce-e900-d942-fb6b-eabb63649591@web.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-11_26:2021-01-11,2021-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Dinghao,

On Sun, 2021-01-10 at 11:50 +0100, Markus Elfring wrote:
> > When kmalloc() fails, tmp_tfm allocated by
> > crypto_alloc_shash() has not been freed, which
> > leads to memleak.

In the future, please conform to Documentation/process/submitting-
patches.rst: 

  - The body of the explanation, line wrapped at 75 columns, which will
    be copied to the permanent changelog to describe this patch.

> 
> Do any Linux developers care for the following aspects?
> 
> * Imperative wordings for change descriptions
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=2ff90100ace886895e4fbb2850b8d5e49d931ed6#n89
> 
> * Usage of the term “memory leak” (instead of an abbreviation)

In general I agree, but this is a really small, obvious bug fix. 
Assuming Dinghao is fine with my updating the patch description, I'll
fix it.

Mimi

