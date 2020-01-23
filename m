Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0702146877
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2020 13:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgAWM4B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jan 2020 07:56:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:57245 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWM4A (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jan 2020 07:56:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 04:55:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,354,1574150400"; 
   d="scan'208";a="288108659"
Received: from wkalinsk-mobl.ger.corp.intel.com ([10.252.23.16])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2020 04:55:53 -0800
Message-ID: <88a1bb22a5f63ff81161f25220d47710420a81ac.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maik Otto <m.otto@phytec.de>, Udit Agarwal <udit.agarwal@nxp.com>,
        dhowells@redhat.com, zohar@linux.vnet.ibm.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     sahil.malhotra@nxp.com, ruchika.gupta@nxp.com,
        horia.geanta@nxp.com, aymen.sghaier@nxp.com
Date:   Thu, 23 Jan 2020 14:55:52 +0200
In-Reply-To: <ae70f48b-be78-ffb8-8b36-0d278b2e19f6@phytec.de>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
         <ae70f48b-be78-ffb8-8b36-0d278b2e19f6@phytec.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-01-17 at 12:52 +0100, Maik Otto wrote:
> Hi
> 
> I tested both patches in combination with
> [RFC,2/2] dm-crypt: Use any key type which is registered from
> https://patchwork.kernel.org/patch/10835633/  with bug fix
> and  an i.MX6Quad (logged device) with Mainline Kernel 4.19.88
> 
> The following tests were successful:
> - key generation with CAAM
> keyctl add secure kmk-master "new 64" @s
> - export and import key blob with same controller
> keyctl pipe 332995568 > secure_key.blob
> reboot device
> keyctl add secure kmk-master "load `cat secure_key.blob`" @s
> - import keyblob with an other cpu and same keys for secure boot
> caam_jr 2102000.jr1: caam op done err: 20000c1a
> [ 185.788931] secure_key: key_blob decap fail (-22)
> add_key: Invalid argument
> => failing import was expected: pass
> - use key from keyring in dmcrypt with an sd-card
> dmsetup create test --table "0 106496 crypt aes-xts-plain64
> :64:secure:kmk-master 0 /dev/mmcblk0p3 0"
> write,read reboot and read again
> 
> Tested-by: Maik Otto<m.otto@phytec.de>

I cannot find the original patch. Can this patch set be
sent together with a cover letter, which is obviously
missing from the earlier version, please.

/Jarkko

