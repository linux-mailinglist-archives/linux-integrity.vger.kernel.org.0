Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EC7467C30
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 18:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352983AbhLCRHq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 12:07:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234423AbhLCRHq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 12:07:46 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3GlfTt011359;
        Fri, 3 Dec 2021 17:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=F+tCGDFIeRp8o33HpdAlZ6K6x/FktEhQuFVJ2RkTMso=;
 b=Rd1BUgXVW74JHXK778SZslCkBpznsfBvGhA1g7JoUBfiAtisf6YO86HPXkCopYbmDZWT
 gZxNWXkYSYfdqLGaDlJoR8ToyTEsEB4T19Mrl15fGEL1oCgM/e+QWvOQlBBCXdxv4VMs
 0ZSUFKAr4rZ/ZsgmY3uCiY8sPMabJxKF1jJ1M73nAsdWOISlNC+h3Ky7BK5Z/ZgRLnZl
 isX6ATPR5K5sDQJdhUmAlKMsVb64B8GWhuyCSeBurSqX2LwHu4mnr7GqbggjCS94yRvJ
 k7/uvrgLYv5sfCNusxrKEuymT/25UZucKouG89nIUIrJz7655pvtgeVhnjAMiv881b0Q hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqq2qraan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 17:04:09 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B3GxFP7016586;
        Fri, 3 Dec 2021 17:04:08 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqq2qraa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 17:04:08 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B3H3OnJ005348;
        Fri, 3 Dec 2021 17:04:07 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 3ckcad8b07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 17:04:07 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B3H45ZZ25559668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 17:04:05 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 221C878067;
        Fri,  3 Dec 2021 17:04:05 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EB297806E;
        Fri,  3 Dec 2021 17:03:42 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 17:03:42 +0000 (GMT)
Message-ID: <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 03 Dec 2021 12:03:41 -0500
In-Reply-To: <20211203023118.1447229-20-stefanb@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
         <20211203023118.1447229-20-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qp2uRPsDduXYHPMRvGASjPlDQXI6KZdu
X-Proofpoint-ORIG-GUID: DuvLoI2KjCwewfDAyl49qjI7oKvoceDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-12-02 at 21:31 -0500, Stefan Berger wrote:
[...]
>  static int securityfs_init_fs_context(struct fs_context *fc)
>  {
> +	int rc;
> +
> +	if (fc->user_ns->ima_ns->late_fs_init) {
> +		rc = fc->user_ns->ima_ns->late_fs_init(fc->user_ns);
> +		if (rc)
> +			return rc;
> +	}
>  	fc->ops = &securityfs_context_ops;
>  	return 0;
>  }

I know I suggested this, but to get this to work in general, it's going
to have to not be specific to IMA, so it's going to have to become
something generic like a notifier chain.  The other problem is it's
only working still by accident:

> +int ima_fs_ns_init(struct ima_namespace *ns)
> +{
> +	ns->mount = securityfs_ns_create_mount(ns->user_ns);

This actually triggers on the call to securityfs_init_fs_context, but
nothing happens because the callback is null.  Every subsequent use of
fscontext will trigger this.  The point of a keyed supeblock is that
fill_super is only called once per key, that's the place we should be
doing this.   It should also probably be a blocking notifier so any
consumer of securityfs can be namespaced by registering for this
notifier.

> +	if (IS_ERR(ns->mount)) {
> +		ns->mount = NULL;
> +		return -1;
> +	}
> +	ns->mount_count = 1;

This is a bit nasty, too: we're spilling the guts of mount count
tracking into IMA instead of encapsulating it inside securityfs.

> +
> +	/* Adjust the trigger for user namespace's early teardown of
> dependent
> +	 * namespaces. Due to the filesystem there's an additional
> reference
> +	 * to the user namespace.
> +	 */
> +	ns->user_ns->refcount_teardown += 1;
> +
> +	ns->late_fs_init = ima_fs_ns_late_init;
> +
> +	return 0;
> +}

I think what should be happening is that we shouldn't so the
simple_pin_fs, which creates the inodes, ahead of time; we should do it
inside fill_super using a notifier, meaning it gets called once per
key, creates the root dentry then triggers the notifier which
instantiates all the namespaced entries.  We can still use
simple_pin_fs for this because there's no locking across fill_super. 
This would mean fill_super would be called the first time the
securityfs is mounted inside the namespace.

If we do it this way, we can now make securityfs have its own mount and
mount_count inside the user namespace, which it uses internally to the
securityfs code, thus avoiding exposing them to ima or any other
namespaced consumer.

I also think we now don't need the securityfs_ns_ duplicated functions
because the callback via the notifier chain now ensures we can use the
namespace they were created in to distinguish between non namespaced
and namespaced entries.

So non-namespaced consumers of securityfs would do what they do now
(calling the securityfs_create on initialization) and namespaced
consumers would register a callback on the notifier which would get
called once for every namespace the securityfs gets mounted in.

I also theorize if we do it with notifiers, we could have a notifier on
kill_sb to tear down all the entires.  If we do this, I think we don't
have to pin any more.

James


