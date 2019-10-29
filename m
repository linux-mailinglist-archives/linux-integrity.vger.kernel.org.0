Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E052AE8BB5
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2019 16:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389299AbfJ2PWO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Oct 2019 11:22:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40564 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfJ2PWN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Oct 2019 11:22:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id o49so20743506qta.7
        for <linux-integrity@vger.kernel.org>; Tue, 29 Oct 2019 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KJ2tUGVkciILzBBgFhdC61JtF6ibtgppsm1fyVjOFLQ=;
        b=MjLxo0CQi64Bmh/eGY+poTwa1hrB2LqoX1NA3eWPKQ+L4Hmh81yIpXJid9IlfSAyUq
         KSIUG7abrSMrkwnEDPbL+MoHpCuisAGc4+EpNLifawyRxS5wiNKtDTLt/9h+Rtz0e/FU
         Jf9WjriqDc7rkrv6WWXLemtgoU7jzUxdDfWuAHtp5K8CY+9M6C8nzmPNQIEIRMr8Nvco
         POiT9OzFzSNaarWqAH9e+BSFTMi9HijpfcvJ9bBnNVl976cqdk7/CaaB49xHysXdsbnp
         DKYtVURgO2ZHzxv5ztyoWSrdeLOXKSoVeTIYG9BGKO3VsptyfqtcZDxtH8LvJhPEo3QA
         VtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJ2tUGVkciILzBBgFhdC61JtF6ibtgppsm1fyVjOFLQ=;
        b=bbGZ66+/kMf3U+3w/4BujG0z6fb8dRAOle0qdJ+NyFEpdJ1xxnzlt2cDxZqx1E1bYw
         IKco5aBPrz4bdRWNFd0swDmcrvVkA0zTIt2/T3cRutuPnll7oEx4dl9Rx+sNmUJLmXpM
         IBdG5frOiEHbBUOk150t/8heKxn1/ZbTOEFhKcpF0AIVARiw5y2gmq0+q14vOkZgT+dp
         bJ8CQg04KDXFwdjBrqidkDpWZ5Iyn2ir5HWDqY5K5cDyiE173qFtc9BlyNP34WFyuSwY
         zn1nFOBlPHF4psKFNNjvsKLoUEQCJxJMJCB629aDRKNGFGvU+n+Qzip6TbktKweqcJ7v
         9kCQ==
X-Gm-Message-State: APjAAAUuxyDTZKxjTYNUS6aTS2fuF5JSFZLuhGeICkZjfgi6zRhXSHo4
        gJi3PVFLyvhkdQYXNsevvAhfj81xNUI=
X-Google-Smtp-Source: APXvYqxLKxy3JJn7ORUklx23t0TpBC6oGDD370s9Bi4F9R2B95vfrG1lX1sLGNq2rZIM4/lkW9AIrQ==
X-Received: by 2002:ac8:28c7:: with SMTP id j7mr4246821qtj.4.1572362532708;
        Tue, 29 Oct 2019 08:22:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id p59sm6906193qtd.2.2019.10.29.08.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 08:22:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPTJz-00073b-DL; Tue, 29 Oct 2019 12:22:11 -0300
Date:   Tue, 29 Oct 2019 12:22:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add major_version sysfs file
Message-ID: <20191029152211.GE6128@ziepe.ca>
References: <20191025193103.30226-1-jsnitsel@redhat.com>
 <20191028205313.GH8279@linux.intel.com>
 <20191028210507.7i6d6b5olw72shm3@cantor>
 <20191029091731.GC9896@linux.intel.com>
 <20191029124342.GB6128@ziepe.ca>
 <20191029142225.GC7415@linux.intel.com>
 <1572361008.4812.2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572361008.4812.2.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 29, 2019 at 07:56:48AM -0700, James Bottomley wrote:
> On Tue, 2019-10-29 at 16:22 +0200, Jarkko Sakkinen wrote:
> > On Tue, Oct 29, 2019 at 09:43:42AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Oct 29, 2019 at 11:17:31AM +0200, Jarkko Sakkinen wrote:
> > > > On Mon, Oct 28, 2019 at 02:05:07PM -0700, Jerry Snitselaar wrote:
> > > > > On Mon Oct 28 19, Jarkko Sakkinen wrote:
> > > > > > On Fri, Oct 25, 2019 at 12:31:03PM -0700, Jerry Snitselaar
> > > > > > wrote:
> > > > > > > +	return sprintf(buf, "%s\n", chip->flags &
> > > > > > > TPM_CHIP_FLAG_TPM2
> > > > > > > +		       ? "2.0" : "1.2");
> > > > > > 
> > > > > > This is not right. Should be either "1" or "2".
> > > > > > 
> > > > > > /Jarkko
> > > > > 
> > > > > Okay I will fix that up. Do we have a final decision on the
> > > > > file name,
> > > > > major_version versus version_major?
> > > > 
> > > > Well, I don't see how major_version would make any sense. It is
> > > > not as future proof as version_major. Still waiting for Jason's
> > > > feedback for this.
> > > 
> > > $ find /sys/ -name  "*version*"
> > > /sys/devices/pci0000:00/0000:00:17.0/ata1/host0/scsi_host/host0/ahc
> > > i_host_version
> > > /sys/devices/virtual/net/docker0/bridge/multicast_mld_version
> > > /sys/devices/virtual/net/docker0/bridge/multicast_igmp_version
> > > /sys/firmware/efi/esrt/entries/entry0/lowest_supported_fw_version
> > > /sys/firmware/efi/esrt/entries/entry0/last_attempt_version
> > > /sys/firmware/efi/esrt/entries/entry0/fw_version
> > > /sys/module/acpi/parameters/acpica_version
> > > 
> > > etc..
> > > 
> > > Not a single example of the backward version.
> > > 
> > > Most likely it should be called 'tpm_version'
> > 
> > The postfix gives tells the part of the version number that the file
> > reports. If you really want to add the prefix, then the appropriate
> > name would be tpm_version_major.
> > 
> > I'd still go with just version_major as tpm_ prefix is somewhat
> > redundant.
> 
> You have to be careful with overly generic names in sysfs ... this is
> what happened to us in SCSI:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42caa0edabd6a0a392ec36a5f0943924e4954311
> 
> That's not to say version_major is wrong ... plenty of sysfs files have
> generic names like this, it's just that tpm_version_major might be more
> future proof.

Indeed, it is a bit a global namespace, so nothing wrong with adding
tpm_

Jason
