Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949D1E0EAA
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2020 14:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390501AbgEYMr4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 May 2020 08:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390488AbgEYMr4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 May 2020 08:47:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B46B3206D5;
        Mon, 25 May 2020 12:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590410876;
        bh=MfX/qODPyzlpjWOLxjVwBODTLMP388rRPyp2GR9ORLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rFRSv7N1H4jnO7kxPpM9O0b1przGuWqBu9tIJl71wz1RbU0vJPMq0tWUGL3+zo+Hb
         2rwmw0VAx4Tpj3we68pm99VU9bUhTFOWPeYQQQI/+a8gz5n+hf4c9mMJ+q5EpSYGGB
         DdM0KPU0lCPElUvwCuRIgam2gEEFkstOAHH9fCwg=
Date:   Mon, 25 May 2020 14:47:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        jens.wiklander@linaro.org, linux-integrity@vger.kernel.org,
        arnd@linaro.org, sumit.garg@linaro.org
Subject: Re: [PATCHv3 2/3] optee: use uuid for sysfs driver entry
Message-ID: <20200525124753.GA797117@kroah.com>
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
 <20200525115235.5405-3-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525115235.5405-3-maxim.uvarov@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 25, 2020 at 02:52:34PM +0300, Maxim Uvarov wrote:
> Optee device names for sysfs needed to be unique
> and it's better if they will mean something. UUID for name
> looks like good solution:
> /sys/bus/tee/devices/optee-clnt-<uuid>

Can you document that in Documentation/ABI/ ?

And why UUID?  Those are usually huge, is that easier than just a unique
number?

thanks,

greg k-h
