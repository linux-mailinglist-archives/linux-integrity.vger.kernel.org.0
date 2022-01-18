Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D67492F90
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 21:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245303AbiARUmo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 15:42:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51282 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238061AbiARUmo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 15:42:44 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IKXnZb010509;
        Tue, 18 Jan 2022 20:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=lvufmgSXOhEp4NlWXuaPh3W+jRMNCuZZX8/ntPvQvVI=;
 b=pu436hMjywVVSLJwjtkLxPZOWnlS1Uu7IiwBqN7Bfs/lte//72xml62x/yvIDat6PmmE
 up0fpZniwGmgUGDm+R33HzgRUFQtkzcTTe4xv/ceiyffmBDw+B0gn+AY5NPA8qubfirb
 JSankqI7Br9HLcgsrSXgAtZGTyUtZXtR9XySk9c6Esv/SDV2nQb759aeJ++NJo4A25JZ
 txwMOg98zch+FOv0A5b3MkHjTDUCF6+BcCNZDbbQoukixyMK2nNfGOHZrI2O514rG3vc
 m8zRj8l2XRmj9rSvtTROwTPiIMz/FIhcyroDXdGva1DKJKRSwFVVdT58M0Irhx59CX3h dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dp1yaw30b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 20:42:30 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20IKSxjg024911;
        Tue, 18 Jan 2022 20:42:30 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dp1yaw2yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 20:42:30 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20IKIspn015708;
        Tue, 18 Jan 2022 20:42:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3dknw96f6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 20:42:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20IKgMmB45351302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 20:42:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB25E42041;
        Tue, 18 Jan 2022 20:42:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA2B942042;
        Tue, 18 Jan 2022 20:42:19 +0000 (GMT)
Received: from sig-9-65-88-194.ibm.com (unknown [9.65.88.194])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jan 2022 20:42:19 +0000 (GMT)
Message-ID: <fbdade37017dd836881c5ecd98fae7313de5b5bb.camel@linux.ibm.com>
Subject: Re: [PATCH v8 07/19] ima: Move dentry into ima_namespace and others
 onto stack
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Tue, 18 Jan 2022 15:42:14 -0500
In-Reply-To: <d53a66a2-17e2-54b3-f115-efd7c58080a7@linux.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
         <20220104170416.1923685-8-stefanb@linux.vnet.ibm.com>
         <a7c5ac94b4c4d87b407353f74ff87bc0b13542a4.camel@linux.ibm.com>
         <d53a66a2-17e2-54b3-f115-efd7c58080a7@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LvMK1ZdIpXV8z_-FIzzNIlCq2_7mh-63
X-Proofpoint-GUID: pwL3tbWKXN8GnY3Csceck8Rfk-pxqGjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_05,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-01-18 at 15:12 -0500, Stefan Berger wrote:
> On 1/13/22 15:28, Mimi Zohar wrote:
> > Hi Stefan,
> >
> > Nobody refers to the IMA securityfs files as dentries.  The Subject
> > line is suppose to provide a hint about the patch.  How about changing
> > the "Subject" line to "ima: Move IMA securityfs files into
> > ima_namespaces or onto stack".
> >
> > On Tue, 2022-01-04 at 12:04 -0500, Stefan Berger wrote:
> >> From: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> Move the policy file dentry into the ima_namespace for reuse by
> >> virtualized SecurityFS and for being able to remove it from
> >> the filesystem. Move the other dentries onto the stack.
> > Missing is an explanation why the other IMA securityfs files can be on
> > the stack.  Maybe start out by saying that the ns_ima_init securityfs
> > files are never deleted.  Then transition into the IMA namespaced
> > securityfs files and how they will be deleted.
> 
> How about this:
> 
> ima: Move IMA securityfs files into ima_namespace or onto stack
> 
> Move the IMA policy file's dentry into the ima_namespace for reuse by
> virtualized securityfs and for being able to remove the file from the
> filesystem using securityfs_remove().

How about "Move the IMA securityfs policy file ..."

> Move the other files' dentries onto the stack since they are not needed

How about "Move the other IMA securityfs files ..."

> outside the function where they are created in. Also, their cleanup is
> automatically handled by the filesystem upon umount of a virtualized
> secruityfs instance, so they don't need to be explicitly freed anymore.
> 
> When moving the dentry 'ima_policy' into ima_namespace rename it to
> 'policy_dentry' to clarify its datatype and avoid a name clash with
> 'int ima_policy' from ima_policy.c.

To prevent namespace pollution, static variables need to be prefixed
(e.g. "ima_").  This is not a concern with variables inside the
ima_namespace structure.  Why not just rename the variable "policy".

Refer to the section on "Naming" in Documentation/process/coding-
style.rst.

thanks,

Mimi

> 
> 
> 
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> ---
> >>   security/integrity/ima/ima.h    |  2 ++
> >>   security/integrity/ima/ima_fs.c | 32 ++++++++++++++++++--------------
> >>   2 files changed, 20 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> >> index 82b3f6a98320..224b09617c52 100644
> >> --- a/security/integrity/ima/ima.h
> >> +++ b/security/integrity/ima/ima.h
> >> @@ -140,6 +140,8 @@ struct ima_namespace {
> >>   	struct mutex ima_write_mutex;
> >>   	unsigned long ima_fs_flags;
> >>   	int valid_policy;
> >> +
> >> +	struct dentry *policy_dentry;
> > None of the other securityfs files are renamed.  Why is "ima_policy"
> > being renamed to "policy_dentry"?  If there is a need, it should be
> > documented in the patch description.
> >
> > thanks,
> >
> > Mimi
> >
> >>   } __randomize_layout;
> >>   extern struct ima_namespace init_ima_ns;
> >>


