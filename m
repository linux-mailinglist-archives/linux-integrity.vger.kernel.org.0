Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444E34663B5
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 13:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbhLBMgp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 07:36:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1346987AbhLBMgp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 07:36:45 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2CHN5e008660;
        Thu, 2 Dec 2021 12:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=CyUZaAnhjgbn2sPd3c/yAmvCxJRBaLX2UbkO4Y/cmZQ=;
 b=ebZiwFZw6kvKKrKS2C68eHUxxPd8pdN24389/CjIC4hlRfNXS7jh/e9xMY2fBfPGogeZ
 qD20GGFmdPTR203GD+YrH1A5XED/uZoQlxtmgNNMtle6D6NUagUyLm6YwMx+O8aIt+kF
 1Upseae9BSEyQDtNXvf1I0qDjquy/Lxa9MvUuNSe41gFEGk54KRA+yZ28K8B5v3hGjPR
 g0Cg6z9MBuAbArehKKNIni+oD6/kDszMuUJ+sEcQIeqYcPTQyFwY5497I6j/Sme2ww+y
 XAsv3AZYlf3tzeRWnEkiIm7u0zZXzcAm3zmG4K3Bhsg/gzBiFx4rt4lVzdRwSEwS7zGY og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpx1408x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 12:33:08 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2CKa0A016410;
        Thu, 2 Dec 2021 12:33:08 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpx1408x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 12:33:08 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2CNOLH013791;
        Thu, 2 Dec 2021 12:33:07 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne32j4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 12:33:07 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2CX5OJ23986568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 12:33:05 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E303778070;
        Thu,  2 Dec 2021 12:33:04 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 981787805F;
        Thu,  2 Dec 2021 12:33:02 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 12:33:02 +0000 (GMT)
Message-ID: <82f874dc0cd580e12162b599f38d22ae8148620d.camel@linux.ibm.com>
Subject: Re: [RFC 17/20] ima: Use integrity_admin_ns_capable() to check
 corresponding capability
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Denis Semakin <denis.semakin@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "mpeters@redhat.com" <mpeters@redhat.com>,
        "lhinds@redhat.com" <lhinds@redhat.com>,
        "lsturman@redhat.com" <lsturman@redhat.com>,
        "puiterwi@redhat.com" <puiterwi@redhat.com>,
        "jamjoom@us.ibm.com" <jamjoom@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "rgb@redhat.com" <rgb@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>
Date:   Thu, 02 Dec 2021 07:33:01 -0500
In-Reply-To: <70960f70d44840789b5f7a847116281e@huawei.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
         <20211130160654.1418231-18-stefanb@linux.ibm.com>
         <7c751783b28766412f158e5ca074748ed18070bd.camel@linux.ibm.com>
         <34085058-ff5f-c28e-c716-6f4fa71747a3@linux.ibm.com>
         <4b12309289c6a51991c5062fed0fde03e0a6f703.camel@linux.ibm.com>
         <70960f70d44840789b5f7a847116281e@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ceyl9KoC-yMZ6zJloRHKhdYAjJ1fUQno
X-Proofpoint-ORIG-GUID: ref2FfurTONIzhsPpxLEIJHgDjb6Dw5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-12-02_07,2021-12-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020080
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-12-02 at 07:16 +0000, Denis Semakin wrote:
> Obviously the main goal by adding new capability was to avoid the
> using CAP_SYS_ADMIN (IOW superuser)

OK, but as I've said a couple of times now: the check for CAP_SYS_ADMIN
doesn't have to be monolithic like this.  We have two sets of checks in
the kernel: capable(..., CAP_SYS_ADMIN) which is for the global
monolithic root like capability and ns_capable(..., CAP_SYS_ADMIN)
which is for the owner (possibly unprivileged) of the user namespace.

This gives us a way of parsing out admin capabilites into the small
subset that the user namespace needs.  Patch 16 changed the check from
capable to ns_capable, meaning it's no longer the monolithic
CAP_SYS_ADMIN.

> to manage IMA stuff, that was also about security granularity.  It's
> good if CAP_MAC_ADMIN will be enough for doing IMA related things
> (write policies and extended attributes).

To be honest, as long as the check resolves to ns_capable(...,
CAP_SYS_<SOMETHING>) I'm not that bothered because the owner of the
user namespace will still pass the check.

> But for me it's a little bit unclear how to deal with unprivileged
> users: assuming there's no CAP_INTEGRITY_ADMIN but CAP_MAC_ADMIN was
> set up, so in this case user can control any LSM (seLinux, SMACK,
> etc) and IMA (policies, xattrs). What if .. for some systems there
> would be some requirements that will allow to touch LSM but do not
> change any IMA (integrity) things? A user can set up any IMA policy
> (it's about the system integrity), modify IMA related xattrs but it's
> forbidden to change seLinux policies and e.g. SMACK labels... May be
> it's unreal scenario of course... but I guess it's not 100%
> impossible.

This is why looking at it as a switch from capable to ns_capable is
useful: an ordinary user can assume ns_capable(..., CAP_SYS_ADMIN)
powers arbitrarily, so its a significant check on where you can make
the switch.

James


