Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32004521CCE
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 16:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbiEJOui (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 10:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345073AbiEJOuG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 10:50:06 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D06309346;
        Tue, 10 May 2022 07:10:27 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 4C681890; Tue, 10 May 2022 09:10:25 -0500 (CDT)
Date:   Tue, 10 May 2022 09:10:25 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, John Johansen <john.johansen@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Micah Morton <mortonm@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v12 01/26] securityfs: rework dentry creation
Message-ID: <20220510141025.GA7290@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-2-stefanb@linux.ibm.com>
 <20220509195414.GA30894@mail.hallyn.com>
 <20220510102525.hlt2rm3k3hg5r6gg@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510102525.hlt2rm3k3hg5r6gg@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 10, 2022 at 12:25:25PM +0200, Christian Brauner wrote:
> On Mon, May 09, 2022 at 02:54:14PM -0500, Serge Hallyn wrote:
> > On Wed, Apr 20, 2022 at 10:06:08AM -0400, Stefan Berger wrote:
> > > From: Christian Brauner <brauner@kernel.org>
> > > 
> > > When securityfs creates a new file or directory via
> > > securityfs_create_dentry() it will take an additional reference on the
> > > newly created dentry after it has attached the new inode to the new
> > > dentry and added it to the hashqueues.
> > > If we contrast this with debugfs which has the same underlying logic as
> > > securityfs. It uses a similar pairing as securityfs. Where securityfs
> > > has the securityfs_create_dentry() and securityfs_remove() pairing,
> > > debugfs has the __debugfs_create_file() and debugfs_remove() pairing.
> > > 
> > > In contrast to securityfs, debugfs doesn't take an additional reference
> > > on the newly created dentry in __debugfs_create_file() which would need
> > > to be put in debugfs_remove().
> > > 
> > > The additional dget() isn't a problem per se. In the current
> > > implementation of securityfs each created dentry pins the filesystem via
> > 
> > Is 'via' an extra word here or is there a missing word?
> > 
> > I'll delay the rest of my response as the missing word may answer my
> > remaining question :)
> 
> It can be both. It should either be removed or it should be followed by
> "securityfs_create_dentry()". securityfs_create_dentry() takes two
> references one in lookup_one_len() and another one explicitly via
> dget(). The latter one isn't needed. Some of that has been covered in an
> earlier thread:
> https://lore.kernel.org/lkml/20220105101815.ldsm4s5yx7pmuiil@wittgenstein

Yes, I saw that two references were being taken.  And near as I can tell,
the second one was never being dropped.  So if you tell me that before this
patch the dentries are never freed, then I'm happy.  Otherwise, I'm
bothered the fact that no matching dput is being deleted in the code (to
match the extra dget being removed).  So where is the code where the final
dput was happening, and is it the d_delete() you're adding which is making
it so that that dput won't be called now?
