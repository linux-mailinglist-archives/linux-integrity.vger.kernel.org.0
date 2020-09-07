Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0073D2602E2
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Sep 2020 19:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgIGRhi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Sep 2020 13:37:38 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:49221 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729741AbgIGRhd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Sep 2020 13:37:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 45551B1E;
        Mon,  7 Sep 2020 13:37:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 07 Sep 2020 13:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=HynftrB+m6bzavPVXIqTX+UejUh
        VZTyD1G0plquryCo=; b=JKqN5IOG4MdBgY3zQauLwKYSJpNDa2c7bt+dusIhNlU
        viR8Wxj6OK0qHU2PkPrt7gPbkuC/sV3xwdA4vjJr+ysXGFdIhbkL3B0OWfALb5zE
        Xf24bH2fCIIJydAvonyoQh+mktnMKRFZ2Q9Gb6ItQDlFhKWv7SfP1RR76uzhML7u
        2/d+zDLEoq/yBKYBsB2N2r1XeMGeNKUKmtxc0yC3zI08YRF0areuHEpbAavKn0QL
        An6MtuuWaV/7Piq+DNkckZ21T0X4hTU+7pEGfiQwN+s47MUdg5KBwKbTI5Mv65hZ
        sOYHpc51GRxXx6KB9r9FL2058e3xu2k9bYipiZatF6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Hynftr
        B+m6bzavPVXIqTX+UejUhVZTyD1G0plquryCo=; b=SvaNRhOrgJBWYRGClh01jt
        vy08PATAyjudQbn7NC9SXeHCjq3J5V7J06mvnqCm1OSkXG2ycY7gPmCiU17+KzOh
        OwBSK4+6DfCbdnczWh529+txzy+lJRLgz85yLHvJn4ef9n8eyVSLINlhGCFsDijU
        1S75PyJ8fP+v673O1oHgLPFRP/5lYH/Qub1/A2q1uOj8C5iyDGXmajyupudj3VJg
        SH3crviIWs9jCN0lZSOl4xukLQmbkwOiTlIa7DuCt1URXFKgPRi+m4J4yfHS2gcL
        UJJ37hd9SNOUz2nlg4Cm8mF7OgL2+cwb2olhpEQUturDLBkxjTQtrjo9MzSUP47w
        ==
X-ME-Sender: <xms:2m9WX_zd-qHTq2Ep82O3G7lMOgsUoE2V7ppL9988RFFW4Vh2-UlYcg>
    <xme:2m9WX3QIh89nIcX7fWP64ZO9uAJ2yu0t1WqIA3O6h8_B5tGX6_HbGSf2AD31JZA99
    sI_DYBwl8j95w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:229WX5UpZwj5llIkieVAlF9g3Ro-pnjS7VdLnMtxOnSb_BA3j5C1Hw>
    <xmx:229WX5j-hxMvcwWFClhQ6jlrm5QXHEU2cYD8UfmW_rk9HZm6J3C9ZQ>
    <xmx:229WXxC7B0AWgzTHKqCYU2308T9Q6HESOxa2uRmxnRWY4Z-bWmIQ_w>
    <xmx:229WXwNqe5_qaeLCasek2wIS2T62fx1PdIArAhGCUQ9ZL6qq_6y43w>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 99FD0328005D;
        Mon,  7 Sep 2020 13:37:30 -0400 (EDT)
Date:   Mon, 7 Sep 2020 19:37:42 +0200
From:   Greg KH <greg@kroah.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of
 PCR registers
Message-ID: <20200907173742.GA1023764@kroah.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
 <20200906203245.18429-2-James.Bottomley@HansenPartnership.com>
 <20200907132121.GA106839@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907132121.GA106839@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 07, 2020 at 04:21:21PM +0300, Jarkko Sakkinen wrote:
> On Sun, Sep 06, 2020 at 01:32:45PM -0700, James Bottomley wrote:
> > Create sysfs per hash groups with 24 PCR files in them one group,
> > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > plugged in to a PCR read function which is TPM version agnostic, so
> > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > 
> > Note: the macros used to create the hashes emit spurious checkpatch
> > warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> > they'll break.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> I'm not sure why this should be in sysfs when event log is in
> securityfs.
> 
> Also, securityfs does not have to follow sysfs requirements,
> which gives ability to dump all PCRs in a single binary file.

You can dump all registers in a single binary file in sysfs as well :)
