Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7525C42C512
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Oct 2021 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhJMPr0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 11:47:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5942 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhJMPr0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 11:47:26 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DEtEQn008807;
        Wed, 13 Oct 2021 11:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=NUJPki3KGMmWDaYljNErOGlAovz5VtzyJpTafaf11rE=;
 b=SvDvo11ycpAr49LTZr2dJCqVLOgG432/h5p5+mc2r89f53pytOztn2ufjKZfnICM7zJ4
 rnEd4DmvjVOmDV3xwuzPND/erD6Z5/G4WhmadcSCyKOyE82Bk2mikT2K96XP0zb8vGbR
 ruPpZP+pKk9LvXEl8rB3qvUdYai9N2QkafwMmpCx5/yHZcCRWgER41kJHFhO3/R3t5fI
 pvDXbnQO953Osv96xxzokKazRb2226K2f31XyI8G2zibclXsbNTcwKrBh8qrNJyAJ+Ba
 rrYj1RVi+iuyCcj6iVJUZDpb272z34ugp9wyj0FuwCBDNDhd1RmIQ7i3jKQ3sIcNfXkg uQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnpf3gajp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 11:45:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DFRRAk012339;
        Wed, 13 Oct 2021 15:45:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q9v91q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 15:45:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DFj8GZ44826940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 15:45:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADE4752067;
        Wed, 13 Oct 2021 15:45:08 +0000 (GMT)
Received: from sig-9-65-208-89.ibm.com (unknown [9.65.208.89])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D1A0E5206D;
        Wed, 13 Oct 2021 15:45:03 +0000 (GMT)
Message-ID: <e1c2d34acb37d85e94af15ca1edd162e1e7f9a2a.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] fs: extend the trusted_for syscall to call IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Date:   Wed, 13 Oct 2021 11:45:01 -0400
In-Reply-To: <d4273866-607e-37be-076b-a920bbf08bf9@digikod.net>
References: <20211013110113.13239-1-zohar@linux.ibm.com>
         <20211013110113.13239-2-zohar@linux.ibm.com>
         <d4273866-607e-37be-076b-a920bbf08bf9@digikod.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TjR-m_N0UdEj6vctAFf7riOsvT3TSVKc
X-Proofpoint-ORIG-GUID: TjR-m_N0UdEj6vctAFf7riOsvT3TSVKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=655 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110130101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[CC'ing Casey]

On Wed, 2021-10-13 at 17:26 +0200, Mickaël Salaün wrote:
> Nice!
> 
> On 13/10/2021 13:01, Mimi Zohar wrote:
> > Extend the trusted_for syscall to call the newly defined
> > ima_trusted_for hook.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  fs/open.c           | 3 +++
> >  include/linux/ima.h | 9 +++++++++
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/fs/open.c b/fs/open.c
> > index c79c138a638c..4d54e2a727e1 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -585,6 +585,9 @@ SYSCALL_DEFINE3(trusted_for, const int, fd, const enum trusted_for_usage, usage,
> >  	err = inode_permission(file_mnt_user_ns(f.file), inode,
> >  			mask | MAY_ACCESS);
> >  
> > +	if (!err)
> > +		err = ima_trusted_for(f.file, usage);
> 
> Could you please implement a new LSM hook instead? Other LSMs may want
> to use this information as well.

Casey normally pushes back on my defining a new LSM hook, when IMA is
the only user.  If any of the LSM maintainers are planning on defining
this hook, please chime in.

thanks,

Mimi

