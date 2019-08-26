Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0269D974
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 00:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfHZWq7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 18:46:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36240 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHZWq6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 18:46:58 -0400
Received: from [10.91.6.157] (unknown [167.220.2.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id D15B720B7186;
        Mon, 26 Aug 2019 15:46:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D15B720B7186
Subject: Re: [PATCH v12 00/11] Appended signatures support for IMA appraisal
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
References: <20190628021934.4260-1-bauerman@linux.ibm.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <9682b5d0-1634-2dd0-2cbb-eb1fa8ba7423@linux.microsoft.com>
Date:   Mon, 26 Aug 2019 15:46:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190628021934.4260-1-bauerman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/27/19 7:19 PM, Thiago Jung Bauermann wrote:
> On the OpenPOWER platform, secure boot and trusted boot are being
> implemented using IMA for taking measurements and verifying signatures.
> Since the kernel image on Power servers is an ELF binary, kernels are
> signed using the scripts/sign-file tool and thus use the same signature
> format as signed kernel modules.
> 
> This patch series adds support in IMA for verifying those signatures.
> It adds flexibility to OpenPOWER secure boot, because it allows it to boot
> kernels with the signature appended to them as well as kernels where the
> signature is stored in the IMA extended attribute.

I know this is pretty late, but I just wanted to let you know that I
tested this patch set on x86_64 with QEMU.

That is, I enrolled a key to _ima keyring, signed my kernel and modules
with appended signatures (with scripts/sign-file), set the IMA policy to
appraise and measure my kernel and modules. Also tested kexec appraisal.

You can add my tested-by if you'd like.

-Jordan
