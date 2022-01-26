Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08C749CA05
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 13:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241500AbiAZMsH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 07:48:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241501AbiAZMsG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 07:48:06 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QBgWqM011847;
        Wed, 26 Jan 2022 12:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=bOqn32E7OwyoHqZX2dW1RM3mqBL4R4QeMtbk/M2u9uA=;
 b=D7epEC9YhNxPVWLWz4MXbD3AxHLxpKVbY1flAAtmtZRSqlXQ5SbD6uRa2/04MPtk6H4S
 DGh9MHFoZjwHBbJ+55TqqwBql2INnIrxhJ4W9B1tuyTUp2tEdmY3WSrEzYipBlJZT5j8
 2jAFS+YzxGXP5gZPWXWw6Mc67czW9MpmFWw+lBAHlwNKfsZ4dBZFAZKPLHqPpUNEUIVf
 BY5fSa/x6WFNA5FEuSurOMjgpsfQX9A6diDXbxQx5e2HTmX9/vegh0acpCFR/oCe7Elx
 4yeUQ0av8kyXFkC8BJmr924+uoqzFDJGOJRcFMu7e7iQe4378hb+ZrlCodFuyWRZdmMU Ew== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3du5ns13wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 12:47:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20QCluQf010811;
        Wed, 26 Jan 2022 12:47:56 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3dr9j9e0y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 12:47:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20QClrSR18743672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 12:47:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2AC64C050;
        Wed, 26 Jan 2022 12:47:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 453834C05A;
        Wed, 26 Jan 2022 12:47:52 +0000 (GMT)
Received: from sig-9-65-92-33.ibm.com (unknown [9.65.92.33])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 12:47:52 +0000 (GMT)
Message-ID: <c1bfe53abaf24feacb676ce940edcb8899924ffc.camel@linux.ibm.com>
Subject: Re: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        roberto.sassu@huawei.com, wangweiyang2@huawei.com,
        xiujianfeng@huawei.com, linux-integrity@vger.kernel.org
Date:   Wed, 26 Jan 2022 07:47:51 -0500
In-Reply-To: <97142483-d7e7-e310-0cb0-30a81414cb57@huawei.com>
References: <20220125090237.120357-1-guozihua@huawei.com>
         <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
         <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
         <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
         <97142483-d7e7-e310-0cb0-30a81414cb57@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BxUT5QFYw52e_HYlRcgyC0fyfvAtKGfS
X-Proofpoint-GUID: BxUT5QFYw52e_HYlRcgyC0fyfvAtKGfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_03,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260076
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-01-26 at 15:41 +0800, Guozihua (Scott) wrote:
> 
> 
> The main issue lies in ima_template_desc_current called by hash_setup, 
> which does not just read ima_template global variable, but also tries to 
> set it if that hasn't been done already. Causing ima_template_setup to quit.

Right, which calls ima_init_template_list().  So part of the solution
could be to conditionally call ima_init_template_list()
in ima_template_setup().

-       if (ima_template)
-               return 1;
-
-       ima_init_template_list();
+       if (!ima_template
+               ima_init_template_list();

Roberto, what do you think?

thanks,

Mimi

