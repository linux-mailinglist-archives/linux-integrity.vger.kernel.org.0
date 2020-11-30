Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0211A2C7F9C
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Nov 2020 09:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgK3ISc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 03:18:32 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:60079 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgK3ISc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 03:18:32 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B39D454C;
        Mon, 30 Nov 2020 03:17:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 30 Nov 2020 03:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=QJ1/n/0c+L4Kvg4Z/+ZQizdRexd
        edUn1wem9EXuv8Kk=; b=CT7mQKMvq3JleGmnFfFM95rElndc+HSAuaXGrMS3CEQ
        RIPuQv7fG6uGc3hIuuKmRImoEG62r94n0x3YvtfAWg0+SUG5r4Mj/kzBuKcOz2u6
        EdGOOPJQpqnLjcCwh5myccFCW6dy+7es4TbdmC5tHj4pQd+6jsFIVFwD0MNcQgqF
        znJtYTFQ9W9Si3SMlfG9y6FNAjZgkLktu/9uj+Ywi1HfKPgcgF/+MQo1skMrtcsw
        EjlqWcks/mNJzjbqlFG6u87eawZsehFaKOC3BIsfx2AyiO/K1qqpFzUJNmXoXHph
        BIqauLZmaQPh/5RW2P6s17UhZ0HeHhW13Fj6vXpcCSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QJ1/n/
        0c+L4Kvg4Z/+ZQizdRexdedUn1wem9EXuv8Kk=; b=iRqW5IC7tkdYUh313j0AJY
        gchKxDC1THEECzfauMZQpRP1bLkOOdyrctuPhY96h8v0gplEctGTgKnOXVu4/fUW
        35x+Olukz9tuBvlnGEyEioJQYESPkF7r+hcM8k5qHzTYvM+tXTtP6GwTBQhWyCnr
        1EI7+UD4AHH2TgnkZo0gfqUEjn5G3tZSZ5lb0WYVjIUdqxZOlfXjK6JkmfvxR8jF
        WWA/u8DO/+4OM/s51gtMOA3Ll2O2Kh8fro4QcyDJ4a7gkvxgkvECZcBZZFjLR98G
        1dGDNuJYQWE9OgKHV5Bf4JeAfBYypEZnjFNyV6oNJDiFM+D8KFgWj6hd3gyiuHHQ
        ==
X-ME-Sender: <xms:qarEX3Io3igHl4d-_nqGunHBPOsI61T-voiKuMMoIEnFix5mUDU8tQ>
    <xme:qarEX7LA-2sM3n0XxPgQ_D8e_P6zS6Bnjn9tVyiPkt7gIEr6WQyIe5b1ONAer90B6
    Y6K492XhICyHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehledguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:qarEX_tPySBDd-zry6XeW2B88D9AbptiqAGSYPcNbUxqw1YMFehNMQ>
    <xmx:qarEXwb82X0UiUjQe09PuRduyJeVJ1-l-hmdvJv2eAS-u2Criv-DlQ>
    <xmx:qarEX-Z2CTQ9zASgqLsiFAARJSxBhaATIohxL3Uqgj_ZQUeYoMnb3g>
    <xmx:qqrEX9k6GlwFRJQmZTLSxJw6JXo-dx80MtbZPJ4AEC3U1BmE6D0akA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 32453328005E;
        Mon, 30 Nov 2020 03:17:45 -0500 (EST)
Date:   Mon, 30 Nov 2020 09:18:49 +0100
From:   Greg KH <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
Message-ID: <X8Sq6VPMtOxPAi3N@kroah.com>
References: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 29, 2020 at 02:30:21PM -0800, James Bottomley wrote:
> Cc to linux-api to get an opinion on two issues.  First the background:
> 
> We've had a fairly extensive discussion over on linux-integrity and
> iterated to the conclusion that the kernel does need to export TPM 2.0
> PCR values for use by a variety of userspace integrity programmes
> including early boot.  The principle clinching argument seems to be
> that these values are required by non-root systems, but in a default
> Linux set up the packet marshalled communication device: /dev/tpmrm0,
> is by default only usable by root.  Historically, TPM 1.2 exported
> these values via sysfs in a single file containing all 24 values:
> 
>   /sys/class/tpm/tpm0/pcrs
> 
> with the format
> 
>   PCR-00: 7D 29 CB 08 0C 0F C4 16 7A 0E 9A F7 C6 D3 97 CD C1 21 A7 69 
>   PCR-01: 9C B6 79 4C E4 4B 62 97 4C AB 55 13 1A 2F 7E AE 09 B3 30 BE 
>   ...

As you know, this breaks the "one value per file" for sysfs, so please,
do not add more files that do this.

> TPM 2.0 adds more complexity: because of it's "agile" format, each TPM
> 2.0 is required to support a set of hashes (of which at least sha1 and
> sha256 are required but quite a few TPM 2.0s have at least two or
> three more) and maintain 24 PCR registers for each supported hash.
> The current patch exports each PCR bank under the directory
> 
>   /sys/class/tpm/tpm0/pcr-<hash>/<bank>
> 
> So the sha256 bank value of PCR 7 can be obtained as
> 
>   cat /sys/class/tpm/tpm0/pcr-sha256/7
>   2ED93F199692DC6788EFA6A1FE74514AB9760B2A6CEEAEF6C808C13E4ABB0D42
> 
> And the output is a single non-space separated ascii hex value of the
> hash.
> 
> The issues we'd like input on are:
> 
>  1. Should this be in sysfs or securityfs?

If you want to use sysfs, use one value per file please.

>   2. Should we export the values as one value per file (current patch)
>      or as a binary blob of all 24?

Binary sysfs files are for "pass-through" mode where the kernel is not
parsing/manipulating the data at all.  Do these values come straight
from the hardware?  If so, sure, use a binary blob.  If not, then no, do
not use that in sysfs as sysfs is to be in text format.

thanks,

greg k-h
