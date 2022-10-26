Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8399A60DD82
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Oct 2022 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiJZItX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Oct 2022 04:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiJZItF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Oct 2022 04:49:05 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D4D7696D;
        Wed, 26 Oct 2022 01:49:04 -0700 (PDT)
Received: (Authenticated sender: nicolas.bouchinet@clip-os.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 408AC240002;
        Wed, 26 Oct 2022 08:48:56 +0000 (UTC)
Date:   Wed, 26 Oct 2022 10:48:55 +0200
From:   Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        brauner@kernel.org, keescook@chromium.org
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
Message-ID: <Y1j0d8kT3WkeoORR@archlinux>
References: <Y1FTSIo+1x+4X0LS@archlinux>
 <5edef60c775117758ecc146f1e8b96ef1c48e3da.camel@linux.ibm.com>
 <Y1Ki8838IAicXzlb@archlinux>
 <8607d166bbd2f32f1e71e5d7ce40b937eaeb410b.camel@linux.ibm.com>
 <Y1flvA2hJn2pNSiJ@archlinux>
 <4e645d7cb3c3d8c8c9af944130eb929851d5ba2f.camel@linux.ibm.com>
 <d18963ca-9c32-c360-144c-fb4a7949d20d@schaufler-ca.com>
 <21fe8e7deb04596f0fdba621b657a21c00a074f1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21fe8e7deb04596f0fdba621b657a21c00a074f1.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On Tue, Oct 25, 2022 at 11:58:40AM -0400, Mimi Zohar wrote:
> On Tue, 2022-10-25 at 08:06 -0700, Casey Schaufler wrote:
> > On 10/25/2022 7:21 AM, Mimi Zohar wrote:
> > > On Tue, 2022-10-25 at 15:33 +0200, Nicolas Bouchinet wrote:
> > >>> Agreed, independently as to whether BPF defines a security xattr, if
> > >>> two LSMs initialize security xattrs, then this change is needed.  Are
> > >>> there any other examples?
> > >> I think that in its current state the kernel cannot load two LSM capable of xattr
> > >> initialization as they are all defined with the `LSM_FLAG_EXCLUSIVE` flag set.
> > >> But I may be unaware of other LSM in development stage.
> > > Casey, Paul, can we get confirmation on this?
> > 
> > I'm working really hard to eliminate LSM_FLAG_EXCLUSIVE. Dealing with
> > multiple security modules initializing security xattrs has been in the
> > stacking patch sets that have been in review for years now. So no,
> > you can't wave the problem away by pointing at LSM_FLAG_EXCLUSIVE.
> 
> Please note that the original problem being addressed by this patch
> will be addressed by Roberto's BPF patch.   The question here was
> whether this addresses an existing bug, other than BPF, or a future
> one, and whether it needs to be backported.
> 
Should I split the NULL pointer dereference fix in a separated patch for EVM ?
> From your response, initializing multiple security xattrs is not an
> issue at the moment so it doesn't need to be backported.  Whether this
> patch should be upstreamed with the LSM stacking patch set is a
> separate question.
> 
> > 
> > >>> (nit: I understand the line size has generally been relaxed, but for
> > >>> IMA/EVM I would prefer it to be remain as 80 chars.)
> > >>>
> > >> No problem, will change it !
> > >>
> > >> I'll take time to run few tests with BPF and send a patch v3 with new changes.
> > > Since Roberto's patches will address the BPF bug(s), is this a fix for
> > > a real bug or a possbile future one.   Cc'ing stable might not be
> > > necessary.
Ok, will remove stable.

Thanks,

Nicolas Bouchinet
