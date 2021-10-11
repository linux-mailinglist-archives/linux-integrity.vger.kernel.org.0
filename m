Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57581428AAD
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Oct 2021 12:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhJKKV0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Oct 2021 06:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbhJKKVY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Oct 2021 06:21:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1024C061745
        for <linux-integrity@vger.kernel.org>; Mon, 11 Oct 2021 03:19:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mZsOv-0000l7-F2; Mon, 11 Oct 2021 12:19:21 +0200
Subject: Re: [PATCH v3] KEYS: trusted: Fix trusted key backends when building
 as module
To:     Andreas Rammhold <andreas@rammhold.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210730012822.3460913-1-andreas@rammhold.de>
 <0d42a11a-0117-49a9-d2c9-bc6cc405235d@pengutronix.de>
 <20210927085104.vq42feghtaqiv6ni@wrt>
 <856359f263575f01d0ce2fcf8f042321f750b38c.camel@linux.ibm.com>
 <20210927200835.wvazk73cek3t5tkf@wrt>
 <2ad2c536367028ef6d9300745586a123cb13d9f1.camel@linux.ibm.com>
 <20210927205521.7c4psu4vz5eoyfnf@wrt>
 <81602197662f3e6d032103bd1ac3690342544b7e.camel@linux.ibm.com>
 <20211002214725.fqmtbfjwtlom745c@wrt>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <db5ea3c2-42df-420b-6813-f6ef2c30df6f@pengutronix.de>
Date:   Mon, 11 Oct 2021 12:19:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211002214725.fqmtbfjwtlom745c@wrt>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mimi, David, Jarkko and James,

On 02.10.21 23:47, Andreas Rammhold wrote:
>> My mistake.  Trusted and encrypted key types have always been defined
>> as tristate.  Only when EVM selects encrypted keys, and by extension
>> trusted keys, are they builtin.
> 
> So how do we go about this patch? Building the TPM support as module has
> broken actually using the trusted backend. This patch fixes that while
> still allowing it to be a builtin. If there is some configuration there
> a module isn't acceptable I am sure that is handled within Kconfig?
Can anyone of you four pick this up? Andreas' regression fix has
had Jarkko's Reviewed-by for close to two months and a half now.

Thanks,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
