Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7D4702B9
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 15:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbhLJOZ7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 09:25:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26118 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232310AbhLJOZ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 09:25:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BADvqjW008448;
        Fri, 10 Dec 2021 14:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=N5gp9F+NAdQIftk6RmNjXqmLEqsrhHuCWY9IvU4rvo0=;
 b=QBM1Q5SJP/60yNh3woD+GvR4qBfDvFOmKtwgKXdjCuKyjJawQc65bIAqsJ2LVfTDyCUT
 K3dpDDztpA4RFjYVtarvWX9MfuNUZZLrwm3PRPpiiU60HQEvH9/eNxaED9288HgetDhZ
 Bm0GrsEMoX5UPtSWerl1L3+M4IFTfDvs2WnmV2qgevbcj3pF3uwdO0xnbxv6uyKwZU/e
 +gxzwoddbEZnnliEOOR1aK5z7Ey/R9aVmY7sb2z+Q2c9pswzW3Cc5pty3X+rdNL1iWAZ
 NPy6aRfPAf7/Gq2czeGcOa2FMrEWXHV1yTGW+FIaVK8grwAgfhwc1euRRalMQNdkZpjs dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv886gfab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 14:22:08 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BADw8ke008759;
        Fri, 10 Dec 2021 14:22:07 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv886gfa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 14:22:07 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAEG38h024099;
        Fri, 10 Dec 2021 14:22:07 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 3cqyycg5jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 14:22:06 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAEM5e228508554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 14:22:05 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3045B78064;
        Fri, 10 Dec 2021 14:22:05 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D38447805C;
        Fri, 10 Dec 2021 14:22:00 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 14:22:00 +0000 (GMT)
Message-ID: <915aa1173be6d73c63f17e7e170da4fe20ed36f3.camel@linux.ibm.com>
Subject: Re: [PATCH v5 13/16] ima: Move some IMA policy and filesystem
 related variables into ima_namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 10 Dec 2021 09:21:59 -0500
In-Reply-To: <dca4e7c9-87a7-9a9e-b1f2-df16f1a45019@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
         <20211208221818.1519628-14-stefanb@linux.ibm.com>
         <20211209191109.o3x7nynnm52zhygz@wittgenstein>
         <0ab33fbc-8438-27b6-ff4c-0321bfc73855@linux.ibm.com>
         <20211210113244.odv2ibrifz2jzft5@wittgenstein>
         <dca4e7c9-87a7-9a9e-b1f2-df16f1a45019@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zCgL4rsL_kAUO7EruqgnCV4s8qE_8tNu
X-Proofpoint-ORIG-GUID: dcvsPHraaPARlH9Po_EMIdo0hLkmu4xi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_04,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-12-10 at 08:57 -0500, Stefan Berger wrote:
> On 12/10/21 06:32, Christian Brauner wrote:
> > On Thu, Dec 09, 2021 at 07:57:02PM -0500, Stefan Berger wrote:
> > > On 12/9/21 14:11, Christian Brauner wrote:
> > > >   From 1f03dc427c583d5e9ebc9ebe9de77c3c535bbebe Mon Sep 17
> > > > 00:00:00 2001
> > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > Date: Thu, 9 Dec 2021 20:07:02 +0100
> > > > Subject: [PATCH] !!!! HERE BE DRAGONS - UNTESTED !!!!
> > > > 
> > > > ---
> > > >    security/integrity/ima/ima_fs.c | 43
> > > > +++++++++++++++++++++++++++++----
> > > >    1 file changed, 38 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/security/integrity/ima/ima_fs.c
> > > > b/security/integrity/ima/ima_fs.c
> > > > index 583462b29cb5..d5b302b925b8 100644
> > > > --- a/security/integrity/ima/ima_fs.c
> > > > +++ b/security/integrity/ima/ima_fs.c
> > > > @@ -317,10 +317,14 @@ static ssize_t ima_read_policy(char
> > > > *path)
> > > >    static ssize_t ima_write_policy(struct file *file, const
> > > > char __user *buf,
> > > >    				size_t datalen, loff_t *ppos)
> > > >    {
> > > > -	struct ima_namespace *ns = get_current_ns();
> > > > +	struct ima_namespace *ns;
> > > > +	struct user_namespace *user_ns;
> > > >    	char *data;
> > > >    	ssize_t result;
> > > > +	user_ns = ima_filp_private(filp);
> > > > +	ns = user_ns->ima_ns
> > > > +
> > > >    	if (datalen >= PAGE_SIZE)
> > > >    		datalen = PAGE_SIZE - 1;
> > > > @@ -373,26 +377,51 @@ static const struct seq_operations
> > > > ima_policy_seqops = {
> > > >    };
> > > >    #endif
> > > > +static struct user_namespace *ima_filp_private(struct file
> > > > *filp)
> > > > +{
> > > > +	if (!(filp->f_flags & O_WRONLY)) {
> > > > +#ifdef CONFIG_IMA_READ_POLICY
> > > > +		struct seq_file *seq;
> > > > +
> > > > +		seq = filp->private_data;
> > > > +		return seq->private;
> > > > +#endif
> > > > +	}
> > > > +	return filp->private_data;
> > > > +}
> > > > +
> > > >    /*
> > > >     * ima_open_policy: sequentialize access to the policy file
> > > >     */
> > > >    static int ima_open_policy(struct inode *inode, struct file
> > > > *filp)
> > > >    {
> > > > -	struct ima_namespace *ns = get_current_ns();
> > > > +	struct user_namespace *user_ns = current_user_ns();
> > > 
> > > Do we have to take a reference on the user namespace assuming one
> > > can open
> > > the file, pass the fd down the hierarchy, and then the user
> > > namespace with
> > > the opened file goes away? Or is there anything else that keeps
> > > the user
> > > namespace alive?
> > No, we don't. When ima_policy_open() is called we do
> > current_user_ns() but that will be guaranteed to be identical to
> > filp->f_cred->user_ns. And f_cred is a reference that has been
> > taken when the vfs allocated a struct file for this .open call so
> > won't go away until the last fput.
> > 
> > My proposal is also too complicated, I think.
> > (The booster is giving me the same side-effects as my second shot
> > so this looks like two good days of fever and headache. So I'll use
> > that as an excuse. :))
> > 
> > Your patch series as it stands has a bit of a security issue with
> > those get_current_ns() calls across differnet file/seq_file
> > operations. 
> > You have to make an architectural decision, I think. I see two
> > sensible options:
> > 1. The relevant ima_ns that .open/.read/.write operate on is always
> > taken to be the ima_ns of the filesystem's userns, i.e. sb-
> > >s_user_ns->ima_ns.
> >     This - but I'm not an ima person - makes the most sense to me
> > and the semantics are straightforward. If I write to a file to
> > alter some policy then I expect the ima namespace of the user
> > namespace to be affected that the securityfs instance was mounted
> > in.
> > 2. The relevant ima_ns that .open/.read/.write operate on is always
> > taken to be the one of the opener. I don't really like that as that
> > gets weird if for some complicated reason the caller is not located
> > in the userns the filesystem was mounted in (weird mount
> > propagation scenario or sm). It also feels strange to operate on an
> > ima_ns that's different from s_user_ns->ima_ns in a securityfs
> > instance.
> 
> We have this situation because one can setns() to another mount 
> namespaces but the data shown by SecurityFS lives in a user
> namespace,  right?

Well, not necessarily.  There is another case where only the userns is
unshared and securityfs is never mounted inside the container.  If the
process has the capability to open the securityfs files (kubernetes
privileged container, say), what should it see? The analogue with the
pid namespace says it should see the contents of the what the parent
had mounted because if it wanted to see its own it would have done a
mount of securityfs inside the userns.  This argues for sb->s_user_ns-
>ima_ns.

for the setns mount namespace case, the vfsmnt tree is duplicated, so
if the securityfs sb->s_user_ns is your user namespace in the prior
mount namespace, it will end up being so in the new one.  sb->s_user_ns 
only changes on actual mount.

>  And now we need to decide whether to affect the data in the
> user namespace  that did the open (option 2) or to which the
> SecurityFS  belongs to (option 1). If we were to open a regular file
> it would be option 1, so we should probably not break that existing
> semantic and also choose option 1 unless there one wasn't allowed to
> choose the user namespace the SecurityFS files belonged to then it
> should be option 2 

Once the userns is unshared, IMA accounting is done inside the
namespace.  However, in order to see the results, the container must
mount securityfs in the userns.  I can't think of a good reason why a
privileged container should want to be accounted separately but see the
results of its parents, but similarly I can't see why a pid namespace
should want to see /proc of its parent either ... yet that's the
semantic we have today.

> but then we have file descriptor passing where 'being allowed' can 
> change depending on who is reading/writing a file... Is there
> anything that would prevent us from setns()'ing to that target user
> namespace so that we would now see that of a user namespace that we
> are not allowed to see?

If you're able to setns to a user namespace, you logically have all its
privileges, so that problem shouldn't arise.

Option 2 is basically sliding back towards securityfs magically
changing properties depending on which userns is asking.  If we're
going to support that, I don't see what was wrong with the owner/guid
magically changing as well like I first propsed.  If we're going to
insist on a new mount of securityfs, I think it has to function cleanly
like the pid namespace, so option 1 is required.

James


