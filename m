Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE9480E89
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Dec 2021 02:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbhL2B3y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Dec 2021 20:29:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54882 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhL2B3y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Dec 2021 20:29:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4EDB6135A;
        Wed, 29 Dec 2021 01:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53C9C36AE7;
        Wed, 29 Dec 2021 01:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640741393;
        bh=ydUgVYXQclY7oFMxL3aKnC9+MuSwNx30h/5qMs9gnOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6MQoAV7g6mJik6mNjyFgC2osFmy/WJaZzEPFxd1RLbZBwE7qRKwvJgbOgArm46NM
         cKD7nISY/GtokKwWCL4o9bVq7SngXRxP9eB8/sM8uznp3YmHWQVeFBUXT4VbXOU248
         2OUVMDDwEAmYa5vnSTFMx94FdoPfs+d051I0wEK893L9hkOFvD7NUMdRDHLpn2V38D
         7YBBNQPmcLoTzACWAg3xtOLTn/SjojeWI90rX8qcubaxOIHzpnCYmceGsztEkdr427
         acFQWKB8gGFsH58ADFwX3XTqPdUXaRbW3pqFw8yGyjW12a2Ki3yxG1ES2mpeb3flLD
         GbdautlPLkoVg==
Date:   Wed, 29 Dec 2021 03:29:50 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 1/3] certs: export load_certificate_list() to be used
 outside certs/
Message-ID: <Ycu6Dq1Tq2cqq/Lf@iki.fi>
References: <20211223013919.206273-1-nayna@linux.ibm.com>
 <20211223013919.206273-2-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223013919.206273-2-nayna@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 22, 2021 at 08:39:17PM -0500, Nayna Jain wrote:
> load_certificate_list() parses certificates embedded in the kernel
> image to load them onto the keyring.
> 
> Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
> function)" made load_certificate_list() a common function in the certs/
> directory. Now, export load_certificate_list() outside certs/ to be used
> by other functions.

It is exported to make callable by load_platform_certificate_list(). Making
anything callable by other functions by itself has no inherit value, and
does not serve as a stimulus to make such code change.

/Jarkko
