Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC31469545
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 12:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbhLFLz7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 06:55:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38284 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbhLFLz6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 06:55:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A798611B4;
        Mon,  6 Dec 2021 11:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE10C341C1;
        Mon,  6 Dec 2021 11:52:23 +0000 (UTC)
Date:   Mon, 6 Dec 2021 12:52:20 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jejb@linux.ibm.com, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
Message-ID: <20211206115220.7ku74xddmmlhbjdh@wittgenstein>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-20-stefanb@linux.ibm.com>
 <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
 <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
 <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
 <cd05433a-3630-e7f5-e144-ff766d7792fa@linux.ibm.com>
 <b285b0d4-e615-bea4-f22f-09d83f8f8edb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b285b0d4-e615-bea4-f22f-09d83f8f8edb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 03, 2021 at 07:33:39PM -0500, Stefan Berger wrote:
> 
> On 12/3/21 14:11, Stefan Berger wrote:
> > 
> > On 12/3/21 13:50, James Bottomley wrote:
> > 
> > 
> > > 
> > > > Where would the vfsmount pointer reside? For now it's in
> > > > ima_namespace, but it sounds like it should be in a more centralized
> > > > place? Should it also be  connected to the user_namespace so we can
> > > > pick it up using get_user_ns()?
> > > exactly.  I think struct user_namespace should have two elements gated
> > > by a #ifdef CONFIG_SECURITYFS which are the vfsmount and the
> > > mount_count for passing into simple_pin_fs.
> > 
> > Also that we can do for as long as it flies beyond the conversation
> > here... :-) Anyone else have an opinion ?
> 
> I moved it now and this greatly reduced the amount of changes. The dentries
> are now all in the ima_namespace and it works with one API. Thanks!

Ideally you only have one entry in struct user_namespace for ima that
encompasses all information needed; not multiple entries. Similar to
what I did for binfmt_misc
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=fs.binfmt_misc&id=eb50eb90a694e05f6fd6533951a56ca3ed040761
if that works.
