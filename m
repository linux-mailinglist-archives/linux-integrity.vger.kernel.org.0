Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1B3B9C5C
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jul 2021 08:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhGBGwN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jul 2021 02:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhGBGwM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 02:52:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 836A861413;
        Fri,  2 Jul 2021 06:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625208581;
        bh=mo46QY2t5vhAtKI/bBVodYsVpTI5odDwqCU6VrYAZFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=inf79rYfYqGyUdMLlMUOuzH0M3QBSdYreJqZXaAAs8xgITxMzfan7F6DWYKFpz0HN
         nepBs1nOvzl/fadqk3LzBMej+2vsgSUPKBpxQg8ugE//KLl/gAjAuQQXWwjupPZmn2
         oJY5tP4H3SGIQq9h7C6JLNlO8GtrMO1vovtCFso+TQr947UYR+BahTrZTE3179QqeE
         jIJ9aiaFa9hUkIQgVtTHeMGzFqCKiD5G5F6BIClaEJKE8GV1AO3kkURA0tMOTmHQtk
         f8auKwxgvmu8dXbrVihbCKpSndQJ8BvdtwbZy12jsgSvJ6iu/Hcxt8Q88YfNAm6qgF
         0HBhlA2qMIpjQ==
Date:   Fri, 2 Jul 2021 09:49:38 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v8 1/2] certs: Trigger creation of RSA module signing key
 if it's not an RSA key
Message-ID: <20210702064938.k2xr2cdtj2oybenc@kernel.org>
References: <20210629213421.60320-1-stefanb@linux.vnet.ibm.com>
 <20210629213421.60320-2-stefanb@linux.vnet.ibm.com>
 <CAHk-=wgVZ6PUJ6Q=vqnhSkHnE2Rvr72xPFjoRU4=HHn-Rqxu4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgVZ6PUJ6Q=vqnhSkHnE2Rvr72xPFjoRU4=HHn-Rqxu4w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 30, 2021 at 12:17:38PM -0700, Linus Torvalds wrote:
> On Tue, Jun 29, 2021 at 2:34 PM Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
> >
> > Address a kbuild issue where a developer created an ECDSA key for signing
> > kernel modules and then builds an older version of the kernel, when bi-
> > secting the kernel for example, that does not support ECDSA keys.
> 
> Thanks, these two don't confuse me any more.
> 
>                 Linus

I'll (re-)test the changes, and make a PR after rc1 out.

/Jarkko
