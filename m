Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B2462C584
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Nov 2022 17:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiKPQzi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Nov 2022 11:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiKPQzR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Nov 2022 11:55:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CA5D48;
        Wed, 16 Nov 2022 08:54:35 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGGoEKI025231;
        Wed, 16 Nov 2022 16:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kuGh5ZshHhvPZ5CEVgWb+338jOu59CC5tuxbY6m9GSU=;
 b=d9KfF9DpQgGGL5OuxLl1E6rMfzUUI9uuSCJsCefobIgT9tJGNNEvqv3kLHdkC9PmjM5o
 0lY6RtVQsKDiiwbOSxhQzdMkku0B0sk38PhTZZhNCuPfQZOZ3MIA00lXUNNsW5ITTcQE
 oS9jg7aqzJ3ApHG5O1bbCjRQc6yXMqs0NbgDSOFrfj0b4WKQUFPJhPM/8DaaAkujv5wI
 SvnAJG7tLnh7ff175aqwCvjyOBZ51aib9fFVMuGm0hY/T8BscXKIzf4ucfc7BzIvcA5A
 X5HWNGwaqGObqJDNw4kAU4NF72bAcGFDFbwPavBIMEUiFGifSfmFtCgAEYkpavmmjIh0 bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw3qt023f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 16:54:13 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AGGpBwL027103;
        Wed, 16 Nov 2022 16:54:12 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw3qt022w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 16:54:12 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGGpH1D016936;
        Wed, 16 Nov 2022 16:54:11 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3kt34a2jw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 16:54:11 +0000
Received: from smtpav02.wdc07v.mail.ibm.com ([9.208.128.114])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AGGsAjX10486356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 16:54:10 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9639F5807A;
        Wed, 16 Nov 2022 16:54:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4533D58058;
        Wed, 16 Nov 2022 16:54:08 +0000 (GMT)
Received: from sig-9-77-134-48.ibm.com (unknown [9.77.134.48])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 16 Nov 2022 16:54:08 +0000 (GMT)
Message-ID: <3531e16685587aa8f3181de5eb84bf26f90a5dfb.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix misuse of dereference of pointer in
 template_desc_init_fields()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Xiujianfeng <xiujianfeng@huawei.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "roberto.sassu@polito.it" <roberto.sassu@polito.it>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 16 Nov 2022 11:54:01 -0500
In-Reply-To: <55100c2e550b4649b5a751ca4596fe7c@huawei.com>
References: <20221112092719.224888-1-xiujianfeng@huawei.com>
         <55100c2e550b4649b5a751ca4596fe7c@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u68NUWLz__BtLRgNKDNb2bAlNWK-0hqB
X-Proofpoint-GUID: yJDXKb6vON_INKKjklOIZJMdojnUNJiJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-11-14 at 08:37 +0000, Roberto Sassu wrote:
> > From: Xiujianfeng
> > Sent: Saturday, November 12, 2022 10:27 AM
> > The input parameter @fields is type of struct ima_template_field ***, so
> > when allocates array memory for @fields, the size of element should be
> > sizeof(**field) instead of sizeof(*field).
> > 
> > Actually the original code would not cause any runtime error, but it's
> > better to make it logically right.
> > 
> > Fixes: adf53a778a0a ("ima: new templates management mechanism")
> > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, applied.

Mimi

