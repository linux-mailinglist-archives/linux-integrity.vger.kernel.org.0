Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4712CE8B4E
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2019 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbfJ2O4x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Oct 2019 10:56:53 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38170 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389095AbfJ2O4x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Oct 2019 10:56:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6F5938EE180;
        Tue, 29 Oct 2019 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1572361012;
        bh=hSAPbbchUW71aepMVeoCwqh6IN8XqeFoWWXaychDyd0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CUnYZRQSwJp/G4unXoq4DjugON9DDRqeog63IrzuT3uOa59rp+uygu4R71hXVqiOy
         GOpmVJvnFNgnGAC4B+aVIiDsuRKAvDBCvyjVlltkXpc7UPYaduGoMg8j/qrOI1FT+E
         TK8D22TdOtNTuXZp5z6ftP47GpU9lgd0vYTofzAc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3ejYJQojYjHj; Tue, 29 Oct 2019 07:56:52 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DB9718EE15F;
        Tue, 29 Oct 2019 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1572361012;
        bh=hSAPbbchUW71aepMVeoCwqh6IN8XqeFoWWXaychDyd0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CUnYZRQSwJp/G4unXoq4DjugON9DDRqeog63IrzuT3uOa59rp+uygu4R71hXVqiOy
         GOpmVJvnFNgnGAC4B+aVIiDsuRKAvDBCvyjVlltkXpc7UPYaduGoMg8j/qrOI1FT+E
         TK8D22TdOtNTuXZp5z6ftP47GpU9lgd0vYTofzAc=
Message-ID: <1572361008.4812.2.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: Add major_version sysfs file
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Date:   Tue, 29 Oct 2019 07:56:48 -0700
In-Reply-To: <20191029142225.GC7415@linux.intel.com>
References: <20191025193103.30226-1-jsnitsel@redhat.com>
         <20191028205313.GH8279@linux.intel.com>
         <20191028210507.7i6d6b5olw72shm3@cantor>
         <20191029091731.GC9896@linux.intel.com> <20191029124342.GB6128@ziepe.ca>
         <20191029142225.GC7415@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-10-29 at 16:22 +0200, Jarkko Sakkinen wrote:
> On Tue, Oct 29, 2019 at 09:43:42AM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 29, 2019 at 11:17:31AM +0200, Jarkko Sakkinen wrote:
> > > On Mon, Oct 28, 2019 at 02:05:07PM -0700, Jerry Snitselaar wrote:
> > > > On Mon Oct 28 19, Jarkko Sakkinen wrote:
> > > > > On Fri, Oct 25, 2019 at 12:31:03PM -0700, Jerry Snitselaar
> > > > > wrote:
> > > > > > +	return sprintf(buf, "%s\n", chip->flags &
> > > > > > TPM_CHIP_FLAG_TPM2
> > > > > > +		       ? "2.0" : "1.2");
> > > > > 
> > > > > This is not right. Should be either "1" or "2".
> > > > > 
> > > > > /Jarkko
> > > > 
> > > > Okay I will fix that up. Do we have a final decision on the
> > > > file name,
> > > > major_version versus version_major?
> > > 
> > > Well, I don't see how major_version would make any sense. It is
> > > not as future proof as version_major. Still waiting for Jason's
> > > feedback for this.
> > 
> > $ find /sys/ -name  "*version*"
> > /sys/devices/pci0000:00/0000:00:17.0/ata1/host0/scsi_host/host0/ahc
> > i_host_version
> > /sys/devices/virtual/net/docker0/bridge/multicast_mld_version
> > /sys/devices/virtual/net/docker0/bridge/multicast_igmp_version
> > /sys/firmware/efi/esrt/entries/entry0/lowest_supported_fw_version
> > /sys/firmware/efi/esrt/entries/entry0/last_attempt_version
> > /sys/firmware/efi/esrt/entries/entry0/fw_version
> > /sys/module/acpi/parameters/acpica_version
> > 
> > etc..
> > 
> > Not a single example of the backward version.
> > 
> > Most likely it should be called 'tpm_version'
> 
> The postfix gives tells the part of the version number that the file
> reports. If you really want to add the prefix, then the appropriate
> name would be tpm_version_major.
> 
> I'd still go with just version_major as tpm_ prefix is somewhat
> redundant.

You have to be careful with overly generic names in sysfs ... this is
what happened to us in SCSI:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42caa0edabd6a0a392ec36a5f0943924e4954311

That's not to say version_major is wrong ... plenty of sysfs files have
generic names like this, it's just that tpm_version_major might be more
future proof.

James


