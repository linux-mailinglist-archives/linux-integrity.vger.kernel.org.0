Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381E647BBDB
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 09:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhLUIaS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 03:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhLUIaR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 03:30:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35994C061574;
        Tue, 21 Dec 2021 00:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3EBF6147C;
        Tue, 21 Dec 2021 08:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC503C36AE7;
        Tue, 21 Dec 2021 08:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640075416;
        bh=bU1LhZZ3j6NaAqdLVZoqf+ybkSagk38IKeD42CrqHzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJEYL4nS4zPNfcvVNGeksl4GEAY5tuykt4vhvJYdonRuRMC0iPQATBPXbOj7ZylBh
         +gvJsYEkOrJCzbl+LwX5zhdMp3zkYz4QuBEDyUQt1frwnUM2cs52guEf7szJAeWHV0
         NUaGNafkar1UWNTo+/7WlCq8W80U3f6FS57pUPACg/QcIcI8COlvWHT2eOVjboX2mD
         PSCcLBdlV+vSfTnXE5WSK2xtGsb6rNUrFxQ3BPhZJLqc8h8NHhFtG5OAlTJfVR6BxW
         81DBeTc4R7YSOAaXYhq0EZ7lYcYWIbO9T3cH7Ecxxo0E8NtlP8tY2lIFrEysCVp9vg
         oRYmkx0ehqVWg==
Date:   Tue, 21 Dec 2021 10:30:15 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yael Tiomkin <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, corbet@lwn.net, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] Instantiate key with user-provided decrypted data.
Message-ID: <YcGQlwIdS+C/OZyt@iki.fi>
References: <20211213192030.125091-1-yaelt@google.com>
 <YcGQMScGMvBd+0+L@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcGQMScGMvBd+0+L@iki.fi>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 21, 2021 at 10:28:33AM +0200, Jarkko Sakkinen wrote:
> On Mon, Dec 13, 2021 at 02:20:30PM -0500, Yael Tiomkin wrote:
> > The encrypted.c class supports instantiation of encrypted keys with
> 
> What is "the encrypted.c class"?

[I'm offw work up until end of the year. That's the reason for some latency
 in responses.]

/Jarkko
