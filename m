Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F582693EE
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Sep 2020 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgINRpm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Sep 2020 13:45:42 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:31105 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgINRph (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Sep 2020 13:45:37 -0400
Received: from xps-7390 (ip68-111-183-238.sd.sd.cox.net [68.111.183.238])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4Bqv0G3RTTzj7n;
        Mon, 14 Sep 2020 13:45:34 -0400 (EDT)
Date:   Mon, 14 Sep 2020 10:45:33 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org
Subject: Re: I'm getting panic()s in tpm2_bios_measurements_start()- but
 don't know why
In-Reply-To: <20200914173548.GA8011@linux.intel.com>
Message-ID: <alpine.DEB.2.23.453.2009141042540.4716@xps-7390>
References: <alpine.DEB.2.23.453.2009121522400.7398@xps-7390> <20200914173548.GA8011@linux.intel.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On Mon, 14 Sep 2020, Jarkko Sakkinen wrote:

> What about stack trace?

It was attached to my original E-mail. But there was nothing special about it,
the _start is just the standard .start call from "struct seq_operations" so
that's where the read ends up.

> Also, are you able to bisect this?

I'd done a checkout of the commit that introduced this routine, it appears
to be this way from the start.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
