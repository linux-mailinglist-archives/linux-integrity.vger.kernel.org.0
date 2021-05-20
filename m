Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D6138A4A5
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 12:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbhETKHa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 06:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235585AbhETKFY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 06:05:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09C3D61353;
        Thu, 20 May 2021 09:41:08 +0000 (UTC)
Date:   Thu, 20 May 2021 11:41:05 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, mjg59@srcf.ucam.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] ima: Introduce template fields mntuidmap and
 mntgidmap
Message-ID: <20210520094105.x2k3bc53xejfl5b2@wittgenstein>
References: <20210520085701.465369-1-roberto.sassu@huawei.com>
 <20210520085701.465369-4-roberto.sassu@huawei.com>
 <20210520093659.oeeytegx2tvzp33e@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210520093659.oeeytegx2tvzp33e@wittgenstein>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 20, 2021 at 11:37:07AM +0200, Christian Brauner wrote:
> On Thu, May 20, 2021 at 10:56:57AM +0200, Roberto Sassu wrote:
> > This patch introduces the new template fields mntuidmap and mntgidmap,
> > which include respectively the UID and GID mappings of the idmapped mount,
> > if the user namespace is not the initial one.
> > 
> > These template fields, which should be included whenever the iuid and the
> > igid fields are included, allow remote verifiers to find the original UID
> > and GID of the inode during signature verification. The iuid and igid
> > fields include the mapped UID and GID when the inode is in an idmapped
> > mount.
> > 
> > This solution has been preferred to providing always the original UID and
> > GID, regardless of whether the inode is in an idmapped mount or not, as
> > the mapped UID and GID are those seen by processes and matched with the IMA
> > policy.
> 
> Hm, looking at the code this doesn't seem like a good idea to me. I
> think we should avoid that and just rely on the original uid and gid.

It'd be ok to include the mapped uid/gid but don't copy the mapping
itself.
