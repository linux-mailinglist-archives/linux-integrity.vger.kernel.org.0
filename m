Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D34476201
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Dec 2021 20:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhLOTlw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 14:41:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229492AbhLOTlw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 14:41:52 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFJMLwo019508;
        Wed, 15 Dec 2021 19:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WVxT8Ac1ecpQQh6nIH+u25zf/5rW1smXIP/iJTHQdeM=;
 b=ripz63iKQvZqSvpaSXllo/SsrjWkonan9A2grYqOLJDVL5yWeURSqprIqLwJHT4zRvaT
 cFH4dCwim5BC/En8atA1D7WWMUK2qwiGh/m6DLDkKEmDnuTtbMVkwdTB9b7kqQdt6r9v
 U0Z9xeE8nqfXqKqVpMdX3cllR/3bvi3nGQoS6TOUVmUjTW0g7hF6EnWi5vYTV0TfR8Af
 VgdkPzzDHJxP2Dk3l1r1n3V/cmvZVlUK/LmqJSkgrNDFbcjgNPVvtQuW1e5FPjVQD6Fh
 1A4TLw0nokUecCmf0Og/JbAheLyGu0d9Ve0whXaLKhrkTt4m6GGAo7LR7UJg8DcCQWnS jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cym1w3x9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 19:41:30 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BFInbUh004824;
        Wed, 15 Dec 2021 19:41:30 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cym1w3x8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 19:41:30 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BFJW1Fx023310;
        Wed, 15 Dec 2021 19:41:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3cy78h8b9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 19:41:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BFJfO7T19333376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 19:41:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC00752052;
        Wed, 15 Dec 2021 19:41:24 +0000 (GMT)
Received: from sig-9-65-74-182.ibm.com (unknown [9.65.74.182])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E90A952063;
        Wed, 15 Dec 2021 19:41:21 +0000 (GMT)
Message-ID: <1de0d8ba760edb7dd18b24bdd39d5424a8c14679.camel@linux.ibm.com>
Subject: Re: [PATCH v6 01/17] ima: Add IMA namespace support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Date:   Wed, 15 Dec 2021 14:41:21 -0500
In-Reply-To: <b4249c5d-da3d-4306-8d9b-10f06ec80cba@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
         <20211210194736.1538863-2-stefanb@linux.ibm.com>
         <b4249c5d-da3d-4306-8d9b-10f06ec80cba@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oREshSvqnATV2pCYT10KD5J60IWkR0P_
X-Proofpoint-GUID: -eqw95S4oVfluCyVXu6WjBSyFPIwCFRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_11,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150108
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-12-13 at 16:11 -0500, Stefan Berger wrote:
> On 12/10/21 14:47, Stefan Berger wrote:
> > Implement an IMA namespace data structure that gets created alongside a
> > user namespace with CLONE_NEWUSER. This lays down the foundation for
> > namespacing the different aspects of IMA (eg. IMA-audit, IMA-measurement,
> > IMA-appraisal).
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > ---
> >   include/linux/ima.h                      | 37 +++++++++++++
> >   include/linux/user_namespace.h           |  4 ++
> >   init/Kconfig                             | 10 ++++
> >   kernel/user.c                            |  7 +++
> >   kernel/user_namespace.c                  |  8 +++
> >   security/integrity/ima/Makefile          |  3 +-
> >   security/integrity/ima/ima.h             |  4 ++
> >   security/integrity/ima/ima_init.c        |  4 ++
> >   security/integrity/ima/ima_init_ima_ns.c | 32 +++++++++++
> >   security/integrity/ima/ima_ns.c          | 69 ++++++++++++++++++++++++
> >   10 files changed, 177 insertions(+), 1 deletion(-)
> >   create mode 100644 security/integrity/ima/ima_init_ima_ns.c
> >   create mode 100644 security/integrity/ima/ima_ns.c
> >
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index b6ab66a546ae..f282e40c316c 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -11,6 +11,7 @@
> >   #include <linux/fs.h>
> >   #include <linux/security.h>
> >   #include <linux/kexec.h>
> > +#include <linux/user_namespace.h>
> >   #include <crypto/hash_info.h>
> >   struct linux_binprm;
> >   
> > @@ -210,6 +211,42 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
> >   }
> >   #endif /* CONFIG_IMA_APPRAISE */
> >   
> > +struct ima_namespace {
> > +	int avoid_zero_size;
> > +};
> 
> 
> I moved the structure to security/integrity/ima/ima.h for v7 and added 
> __randomize_layout to it.

Much better than being in the public ima.h.

thanks!

Mimi

