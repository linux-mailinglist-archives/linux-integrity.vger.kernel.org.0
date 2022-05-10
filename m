Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14381521228
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 12:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbiEJK3e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 06:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiEJK3d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 06:29:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4DF5995C;
        Tue, 10 May 2022 03:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5369B81A8D;
        Tue, 10 May 2022 10:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BCAC385C6;
        Tue, 10 May 2022 10:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652178334;
        bh=c1LkgsSL5u1W+FxOU36QPj5ag+kYFOKzMbzuhaFp0JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7wGjYBvhOavYyk41py6LIu+fJtrWpa/3jGfY/hv0NSX7ywOjj9F0EVDFrlx3KZT3
         l7Wnf/bLGNCIDMCj+eYhOYxJDmCJTbSJKqtCVVim7hm7/U7CIFhTS4EddtzPKGwz7x
         98osBKjr3SmLWnL2qNhwMU7sT3zrmhm8/UCrH+WcB/RqmA/2JgFchm7xLKgVwrlfgZ
         yvNHohCclsUoKVoCEQ/8SuEwnlZ+N6lTQli18BYlXpTP97Ev00RU5GF4WrSvIHNv7Q
         BfJGiXix29ihxqFnqloF688M/wGkdYtdFgRfRFn93SiulMMBgk3+S5T73UIdp/kCoy
         9tmdCfTRsDwnw==
Date:   Tue, 10 May 2022 12:25:25 +0200
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
Message-ID: <20220510102525.hlt2rm3k3hg5r6gg@wittgenstein>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-2-stefanb@linux.ibm.com>
 <20220509195414.GA30894@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509195414.GA30894@mail.hallyn.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 02:54:14PM -0500, Serge Hallyn wrote:
> On Wed, Apr 20, 2022 at 10:06:08AM -0400, Stefan Berger wrote:
> > From: Christian Brauner <brauner@kernel.org>
> > 
> > When securityfs creates a new file or directory via
> > securityfs_create_dentry() it will take an additional reference on the
> > newly created dentry after it has attached the new inode to the new
> > dentry and added it to the hashqueues.
> > If we contrast this with debugfs which has the same underlying logic as
> > securityfs. It uses a similar pairing as securityfs. Where securityfs
> > has the securityfs_create_dentry() and securityfs_remove() pairing,
> > debugfs has the __debugfs_create_file() and debugfs_remove() pairing.
> > 
> > In contrast to securityfs, debugfs doesn't take an additional reference
> > on the newly created dentry in __debugfs_create_file() which would need
> > to be put in debugfs_remove().
> > 
> > The additional dget() isn't a problem per se. In the current
> > implementation of securityfs each created dentry pins the filesystem via
> 
> Is 'via' an extra word here or is there a missing word?
> 
> I'll delay the rest of my response as the missing word may answer my
> remaining question :)

It can be both. It should either be removed or it should be followed by
"securityfs_create_dentry()". securityfs_create_dentry() takes two
references one in lookup_one_len() and another one explicitly via
dget(). The latter one isn't needed. Some of that has been covered in an
earlier thread:
https://lore.kernel.org/lkml/20220105101815.ldsm4s5yx7pmuiil@wittgenstein
