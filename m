Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01797C475D
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Oct 2023 03:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbjJKBiG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Oct 2023 21:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344660AbjJKBiF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Oct 2023 21:38:05 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD793;
        Tue, 10 Oct 2023 18:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FJaA2on43XmsVHxzWxKShJCY7mwJUIvIKrju6oJNWi0=; b=a+M3wW/KjFcIVXQe0+RFVrxSJU
        HMFKAcBHS17013D0KJJpaKUfhDO8eONxBe7159UbmpX0chcLxxVR90u1bLb70JuwBUCoSoTCZ6bEb
        wO7ME29kmHmCaFl+sLsFiXPTA4b/IbyhzPkmwJLSBSxXnQ0SRMuDAOa4OpsIvBtP/6AFTxe093rUo
        hftyQRP61h1eWJkohE6FUm4cXEUsFUioCxOciIr3F4USZkAA5LkG99mTWMhlh7NsAvqCQltyy37L4
        rO/fdxqDV+Iv9tWfIOH3HtJRbn49lG1OQb5GNrhNypGqeiwkXhUw7zEYAJfwTE54fbK0K4+42WYXM
        qe4/cftw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqOAe-000739-0R;
        Wed, 11 Oct 2023 01:37:56 +0000
Date:   Wed, 11 Oct 2023 02:37:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
Message-ID: <20231011013756.GT800259@ZenIV>
References: <20231009153712.1566422-1-amir73il@gmail.com>
 <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
 <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
 <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
 <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
 <20231010165504.GP800259@ZenIV>
 <20231010174146.GQ800259@ZenIV>
 <CAJfpegtbOG0DqyuQ=xt2KDh5WDaZBb0tLJuhqa2jyQfHSMfO-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtbOG0DqyuQ=xt2KDh5WDaZBb0tLJuhqa2jyQfHSMfO-w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 10, 2023 at 08:14:15PM +0200, Miklos Szeredi wrote:
> On Tue, 10 Oct 2023 at 19:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Oct 10, 2023 at 05:55:04PM +0100, Al Viro wrote:
> > > On Tue, Oct 10, 2023 at 03:34:45PM +0200, Miklos Szeredi wrote:
> > > > On Tue, 10 Oct 2023 at 15:17, Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > > Sorry, you asked about ovl mount.
> > > > > To me it makes sense that if users observe ovl paths in writable mapped
> > > > > memory, that ovl should not be remounted RO.
> > > > > Anyway, I don't see a good reason to allow remount RO for ovl in that case.
> > > > > Is there?
> > > >
> > > > Agreed.
> > > >
> > > > But is preventing remount RO important enough to warrant special
> > > > casing of backing file in generic code?  I'm not convinced either
> > > > way...
> > >
> > > You definitely want to guarantee that remounting filesystem r/o
> > > prevents the changes of visible contents; it's not just POSIX,
> > > it's a fairly basic common assumption about any local filesystems.
> >
> > Incidentally, could we simply keep a reference to original struct file
> > instead of messing with path?
> >
> > The only caller of backing_file_open() gets &file->f_path as user_path; how
> > about passing file instead, and having backing_file_open() do get_file()
> > on it and stash the sucker into your object?
> >
> > And have put_file_access() do
> >         if (unlikely(file->f_mode & FMODE_BACKING))
> >                 fput(backing_file(file)->file);
> > in the end.
> 
> That's much nicer, I like it.

Won't work, unfortunately ;-/  We have the damn thing created on open();
it really can't pin the original file, or we'll never get to closing it.

I don't think this approach could be salvaged - we could make that
reference non-counting outside of mmap(), but we have no good way to
catch the moment when it should be dropped; not without intercepting
vm_ops->close() (and thus vm_ops->open() as well)...

Oh, well..
