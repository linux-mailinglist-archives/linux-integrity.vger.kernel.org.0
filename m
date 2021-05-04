Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5237243C
	for <lists+linux-integrity@lfdr.de>; Tue,  4 May 2021 03:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhEDBZH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 21:25:07 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:33730 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhEDBZH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 21:25:07 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B9C3D72C8B5;
        Tue,  4 May 2021 04:24:11 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 803D94A46E8;
        Tue,  4 May 2021 04:24:11 +0300 (MSK)
Date:   Tue, 4 May 2021 04:24:11 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH] ima-evm-utils: Allow manual setting keyid for signing
Message-ID: <20210504012411.2rxkuagbd7czpces@altlinux.org>
References: <20210430201334.3643230-1-vt@altlinux.org>
 <f9e2296e-3b84-c440-8486-f2c8bd9fde60@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <f9e2296e-3b84-c440-8486-f2c8bd9fde60@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Mon, May 03, 2021 at 04:25:08PM -0400, Stefan Berger wrote:
> 
> On 4/30/21 4:13 PM, Vitaly Chikunov wrote:
> > Allow user to set signature's keyid using `--keyid' option. Keyid should
> > correspond to SKID in certificate, when keyid is calculated using SHA-1
> > in libimaevm it may mismatch keyid extracted by the kernel from SKID of
> > certificate (the way public key is presented to the kernel), thus making
> > signatures not verifiable. This may happen when certificate is using non
> > SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
> > As a last resort user may specify arbitrary keyid using the new option.
> > 
> > This commit creates backward compatible ABI change for libimaevm,
> > because of adding additional parameter to imaevm_params - older
> > libimaevm can work with newer client.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> > 
> > +		case 143:
> > +			errno = 0;
> > +			keyid = strtoul(optarg, &eptr, 16);
> > +			if (errno || eptr - optarg != strlen(optarg) ||
> > +			    keyid > UINT_MAX || keyid == 0) {
> > +				log_err("Invalid keyid value.\n");
> > +				exit(1);
> > +			}
> > +			imaevm_params.keyid = htonl(keyid);
> 
> 
> I would leave it in native format here ...
> 
> 
> >   		log_err("sign_hash_v2: hash is null\n");
> > @@ -932,8 +931,10 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
> >   		return -1;
> >   	}
> > -	calc_keyid_v2(&keyid, name, pkey);
> > -	hdr->keyid = keyid;
> > +	if (imaevm_params.keyid)
> > +		hdr->keyid = imaevm_params.keyid;
> 
> 
> ... and convert it to big endian here when you write it out and where it
> needs to be in big endian format.

I agree.

Also, I have additional idea - when user specify private signing key
with `--key' they can have combined key+cert pem file, in that case we
could try to extract appropriate keyid from the same file. I will send
another patch set.

Thanks,

