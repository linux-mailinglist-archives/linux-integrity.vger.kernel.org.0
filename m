Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05BF522034
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 17:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346547AbiEJP6k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347876AbiEJP6K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 11:58:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BC462CF2;
        Tue, 10 May 2022 08:51:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EA0161373;
        Tue, 10 May 2022 15:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88345C385A6;
        Tue, 10 May 2022 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652197876;
        bh=6JxcE5t9KXVE8fMNIQQ+vlROON2kYoaeG2ur0y4wic8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=akwaLFkg0R/3GizbON24I88jiLQHcxNG8NGP6pKgKS5C20Khy1Y7xZNOmJ1vAelWH
         rklD2/xr0jvYdgTPQ+bgI54Yis5lQ6qpm8zKgAAGNREmUk4dP47T37AtmFAVt+9ZLn
         7ybau9gnxTutbjks0xu5bdYaLWBF0fhuuYhnHQ/NGnWoLHD6xpBik/lQlltS3OxC8m
         5DPiB0+mHyrLbixkwNyrsKK7V/DIGaYhx8ekCyDDC39Oq0NGXSFIMw4oGVoLfqe1Ad
         SQJXjYjCBSBCP0Tfxpj4Wnb/XvmucYWbOg/cO1t+HaI8YoTDuVXsRzdCbUGDmZqWDy
         MHmI9I4lAIjAA==
Date:   Tue, 10 May 2022 17:51:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
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
Message-ID: <20220510155107.srxifzuqfstvet2f@wittgenstein>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-2-stefanb@linux.ibm.com>
 <20220509195414.GA30894@mail.hallyn.com>
 <20220510102525.hlt2rm3k3hg5r6gg@wittgenstein>
 <20220510141025.GA7290@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220510141025.GA7290@mail.hallyn.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 10, 2022 at 09:10:25AM -0500, Serge Hallyn wrote:
> On Tue, May 10, 2022 at 12:25:25PM +0200, Christian Brauner wrote:
> > On Mon, May 09, 2022 at 02:54:14PM -0500, Serge Hallyn wrote:
> > > On Wed, Apr 20, 2022 at 10:06:08AM -0400, Stefan Berger wrote:
> > > > From: Christian Brauner <brauner@kernel.org>
> > > > 
> > > > When securityfs creates a new file or directory via
> > > > securityfs_create_dentry() it will take an additional reference on the
> > > > newly created dentry after it has attached the new inode to the new
> > > > dentry and added it to the hashqueues.
> > > > If we contrast this with debugfs which has the same underlying logic as
> > > > securityfs. It uses a similar pairing as securityfs. Where securityfs
> > > > has the securityfs_create_dentry() and securityfs_remove() pairing,
> > > > debugfs has the __debugfs_create_file() and debugfs_remove() pairing.
> > > > 
> > > > In contrast to securityfs, debugfs doesn't take an additional reference
> > > > on the newly created dentry in __debugfs_create_file() which would need
> > > > to be put in debugfs_remove().
> > > > 
> > > > The additional dget() isn't a problem per se. In the current
> > > > implementation of securityfs each created dentry pins the filesystem via
> > > 
> > > Is 'via' an extra word here or is there a missing word?
> > > 
> > > I'll delay the rest of my response as the missing word may answer my
> > > remaining question :)
> > 
> > It can be both. It should either be removed or it should be followed by
> > "securityfs_create_dentry()". securityfs_create_dentry() takes two
> > references one in lookup_one_len() and another one explicitly via
> > dget(). The latter one isn't needed. Some of that has been covered in an
> > earlier thread:
> > https://lore.kernel.org/lkml/20220105101815.ldsm4s5yx7pmuiil@wittgenstein
> 
> Yes, I saw that two references were being taken.  And near as I can tell,
> the second one was never being dropped.  So if you tell me that before this
> patch the dentries are never freed, then I'm happy.  Otherwise, I'm
> bothered the fact that no matching dput is being deleted in the code (to
> match the extra dget being removed).  So where is the code where the final
> dput was happening, and is it the d_delete() you're adding which is making
> it so that that dput won't be called now?

* So consider mounting securityfs _without this patch applied_:

  mount -t securityfs /sfs
  
  and assume we only have a single user that creates a file "foo" via
  
  securityfs_create_file()
  {
  	lookup_one_len();	// first dget()
  	dget();			// second dget()
  }
  
  now assume that user at some point calls
  
  void securityfs_remove()
  {
  	if (d_is_dir(dentry))
  		simple_rmdir(dir, dentry);	// first dput()
  	else
  		simple_unlink(dir, dentry);	// first dput()
  	dput(dentry);				// second dput()
  }

* Now consider mounting securityfs _with this patch applied_:

  securityfs_create_file()
  {
  	lookup_one_len();	// first dget()
  }
  
  void securityfs_remove()
  {
  	dget();					// second dget() 
  	if (d_is_dir(dentry))
  		simple_rmdir(dir, dentry);	// first dput()
  	else
  		simple_unlink(dir, dentry);	// first dput()
  	dput(dentry);				// second dput()
  }
