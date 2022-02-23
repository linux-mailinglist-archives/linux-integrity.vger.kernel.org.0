Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803D74C1A70
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 19:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbiBWSAf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 13:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbiBWSAc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 13:00:32 -0500
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3E63EAA8;
        Wed, 23 Feb 2022 09:59:56 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 60528821; Wed, 23 Feb 2022 11:51:21 -0600 (CST)
Date:   Wed, 23 Feb 2022 11:51:21 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>
Subject: Re: [PATCH v10 12/27] ima: Define mac_admin_ns_capable() as a
 wrapper for ns_capable()
Message-ID: <20220223175121.GA10272@mail.hallyn.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-13-stefanb@linux.ibm.com>
 <20220205055826.GA15072@mail.hallyn.com>
 <9c8a09d6-6373-c8c2-c8ff-2b4c3f92ddf1@linux.ibm.com>
 <cb94bd18-2d6c-772f-b16e-a4778480258b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb94bd18-2d6c-772f-b16e-a4778480258b@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 07, 2022 at 01:43:31PM -0500, Stefan Berger wrote:
> 
> On 2/6/22 12:20, Stefan Berger wrote:
> > 
> > On 2/5/22 00:58, Serge E. Hallyn wrote:
> > > On Tue, Feb 01, 2022 at 03:37:20PM -0500, Stefan Berger wrote:
> > > > Define mac_admin_ns_capable() as a wrapper for the combined
> > > > ns_capable()
> > > > checks on CAP_MAC_ADMIN and CAP_SYS_ADMIN in a user namespace. Return
> > > > true on the check if either capability or both are available.
> > > > 
> > > > Use mac_admin_ns_capable() in place of capable(SYS_ADMIN). This
> > > > will allow
> > > > an IMA namespace to read the policy with only CAP_MAC_ADMIN, which has
> > > > less privileges than CAP_SYS_ADMIN.
> > > > 
> > > > Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > ---
> > > >   include/linux/capability.h      | 6 ++++++
> > > >   security/integrity/ima/ima.h    | 6 ++++++
> > > >   security/integrity/ima/ima_fs.c | 5 ++++-
> > > >   3 files changed, 16 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/capability.h b/include/linux/capability.h
> > > > index 65efb74c3585..991579178f32 100644
> > > > --- a/include/linux/capability.h
> > > > +++ b/include/linux/capability.h
> > > > @@ -270,6 +270,12 @@ static inline bool
> > > > checkpoint_restore_ns_capable(struct user_namespace *ns)
> > > >           ns_capable(ns, CAP_SYS_ADMIN);
> > > >   }
> > > >   +static inline bool mac_admin_ns_capable(struct user_namespace *ns)
> > > > +{
> > > > +    return ns_capable(ns, CAP_MAC_ADMIN) ||
> > > > +        ns_capable(ns, CAP_SYS_ADMIN);
> > > Do you care about audit warnings?  If the task has CAP_SYS_ADMIN but
> > > not CAP_MAC_ADMIN, is it desirable that selinux_capable() will audit the
> > > CAP_MAC_ADMIN failure?
> > 
> > Good point.  I will switch both to ns_capable_noaudit() so that the user
> > cannot provoke unnecessary audit message.
> 
> Actually,  I will only change the MAC_ADMIN to not do auditing and not
> change the auditing behavior related to SYS_ADMIN.

Right, that makes the most sense.
