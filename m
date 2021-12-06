Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74336469748
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 14:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbhLFNm7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 08:42:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240974AbhLFNm7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 08:42:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6BkBLA010392;
        Mon, 6 Dec 2021 13:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=Hxaf4yoQ+z04Q8UBPb0ijD/plu32Q9Rh363cLjYlSh8=;
 b=mS/sUfHKyXzzKQQWM0PytpLpQQgAGB0eymlyERtQO2ElYwDFwd3GN2Dkz0m4/8GFaUgI
 MZiJqtKcOSmZUiNZ2zH5lb4SM8RMX9ECA76duY+7Va+7chbFZ7ZGU69/prIIfkpWuWFt
 9avhafaOJbRVQ9+zd453bVAzN+9uuL78On8QPVG6OMww1W34CIl0EYlOQiLMCnVGOhL9
 ioMAFWzMLg4ilk7bJHI7I8XlW7XZBc27lp1Bus89c7xaazrLrtgL5HX+F4Jk8TPK9PVh
 d2C68wLWOFiJj4Mfob6SbdRLWBQ23F0sJwXbWbiYiq5B6OORTDnd2dB1wZmSuPNbp8/C uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3csh56b402-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 13:38:35 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6CoOdV012218;
        Mon, 6 Dec 2021 13:38:35 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3csh56b3yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 13:38:35 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6DXnIu009339;
        Mon, 6 Dec 2021 13:38:34 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3cqyy9mkx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 13:38:34 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6DcWBI40698202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 13:38:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0A4978074;
        Mon,  6 Dec 2021 13:38:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C0FC78077;
        Mon,  6 Dec 2021 13:38:30 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 13:38:30 +0000 (GMT)
Message-ID: <36c97ac9821dfc03aa7b370648c8be423979cc5a.camel@linux.ibm.com>
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Mon, 06 Dec 2021 08:38:29 -0500
In-Reply-To: <20211206120847.ayr3zycigld6rf4j@wittgenstein>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
         <20211203023118.1447229-20-stefanb@linux.ibm.com>
         <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
         <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
         <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
         <ed654d0f-6194-ce29-a854-3d9128d81b7a@schaufler-ca.com>
         <20211206120847.ayr3zycigld6rf4j@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gaVqaaL1F-YRgKsOwbO5PBg1kR00TExY
X-Proofpoint-ORIG-GUID: _y_YxJRVIGYqZGw3YzQqf_rXkLephTcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_04,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-12-06 at 13:08 +0100, Christian Brauner wrote:
> On Fri, Dec 03, 2021 at 11:37:14AM -0800, Casey Schaufler wrote:
> > On 12/3/2021 10:50 AM, James Bottomley wrote:
> > > On Fri, 2021-12-03 at 13:06 -0500, Stefan Berger wrote:
> > > > On 12/3/21 12:03, James Bottomley wrote:
> > > > > On Thu, 2021-12-02 at 21:31 -0500, Stefan Berger wrote:
> > > > > [...]
> > > > > >    static int securityfs_init_fs_context(struct fs_context
> > > > > > *fc)
> > > > > >    {
> > > > > > +	int rc;
> > > > > > +
> > > > > > +	if (fc->user_ns->ima_ns->late_fs_init) {
> > > > > > +		rc = fc->user_ns->ima_ns->late_fs_init(fc-
> > > > > > >user_ns);
> > > > > > +		if (rc)
> > > > > > +			return rc;
> > > > > > +	}
> > > > > >    	fc->ops = &securityfs_context_ops;
> > > > > >    	return 0;
> > > > > >    }
> > > > > I know I suggested this, but to get this to work in general,
> > > > > it's going to have to not be specific to IMA, so it's going
> > > > > to have to become something generic like a notifier
> > > > > chain.  The other problem is it's only working still by
> > > > > accident:
> > > >  
> > > > I had thought about this also but the rationale was:
> > > > 
> > > > securityfs is compiled due to CONFIG_IMA_NS and the user
> > > > namespace exists there and that has a pointer now to
> > > > ima_namespace, which can have that callback. I assumed that
> > > > other namespaced subsystems could also be  reached then via
> > > > such a callback, but I don't know.
> > >  
> > > Well securityfs is supposed to exist for LSMs.  At some point
> > > each of those is going to need to be namespaced, which may
> > > eventually be quite a pile of callbacks, which is why I thought
> > > of a notifier.
> > 
> > While AppArmor, lockdown and the integrity family use securityfs,
> > SELinux and Smack do not. They have their own independent
> > filesystems. Implementations of namespacing for each of SELinux and
> > Smack have been proposed, but nothing has been adopted. It would be
> > really handy to namespace the infrastructure rather than each
> > individual LSM, but I fear that's a bigger project than anyone will
> > be taking on any time soon. It's likely to encounter many of the
> > same issues that I've been dealing with for module stacking.
> 
> The main thing that bothers me is that it uses simple_pin_fs() and
> simple_unpin_fs() which I would try hard to get rid of if possible.
> The existence of this global pinning logic makes namespacing it
> properly more difficult then it needs to be and it creates imho wonky
> semantics where the last unmount doesn't really destroy the
> superblock.

So in the notifier sketch I posted, I got rid of the pinning but only
for the non root user namespace use case ... which basically means only
for converted consumers of securityfs.  The last unmount of securityfs
inside the namespace now does destroy the superblock ... I checked.

The same isn't true for the last unmount of the root namespace, but
that has to be so to keep the current semantics.

>  Instead subsequents mounts resurface the same superblock. There
> might be an inherent design reason why this needs to be this way but
> I would advise against these semantics for anything that wants to be
> namespaced. Probably the first securityfs mount in init_user_ns can
> follow these semantics but ones tied to a non-initial user namespace
> should not as the userns can go away. In that case the pinning logic
> seems strange as conceptually the userns pins the securityfs mount as
> evidenced by the fact that we key by it in get_tree_keyed().

Yes, that's basically what I did: pin if ns == &init_user_ns but don't
pin if not.  However, I'm still not sure I got the triggers right.  We
have to trigger the notifier call (which adds the namespaced file
entries) from context free, because that's the first place the
superblock mount is fully set up ... I can't do it in fill_super
because the mount isn't fully initialized (and the locking prevents
it).  I did manage to get the notifier for teardown triggered from
kill_super, though.

James


