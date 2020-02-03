Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D646150E3F
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2020 17:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBCQ64 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Feb 2020 11:58:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33092 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgBCQ64 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Feb 2020 11:58:56 -0500
Received: by mail-pj1-f67.google.com with SMTP id m7so86689pjs.0;
        Mon, 03 Feb 2020 08:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YyTHPIBZyo/MqH3zpBfQtUfIWIJ/AY6jdQ6GQWRTFQ=;
        b=H4PYtBpNnwNZ74ttAJKAvXj+XXpucjbenNa4WCoLfSGkMAEfWgHv37RfodC9wFUsLz
         i9xOLmJvsImDMk9gqhxd4SmlznZPEqTCoO0grr+kJNl8WRmkvftYS9xd12xMV357JBC3
         xTUHh0enPsXgV7bt8TAMhOTTyUj+8HwNq46Fy8joPbZ+NafT8l+ohQWfPg1wus+a4p9g
         eZIPf7504WyS1c4N1YlkEw2+DABbPEFt6HWYuhvP/GFdEp8U+UOePR56Emf0fgJueqJ/
         +Dwvgq1CBDDenZLiuRRQh1c2UQLuXp0Kxbt1vP7Quc7zqUNWp5jLv2HaKVrhut2j6sWK
         dMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YyTHPIBZyo/MqH3zpBfQtUfIWIJ/AY6jdQ6GQWRTFQ=;
        b=GnrI7b4PDRmm/UJOgaNSXzbbL1x/ATcmnKevPwmjWnAZgzR5+1RPKjjkiXJbC0kxPb
         A4p/i3q3HkkfrC1SbyWvwJYL9xbDnN61TdroW8Atz3ZDy8wNficLG4mIUZeTE9qvfyBL
         0IqjQ+RXoU+wzJV6zThhUnAMVkMRNgtJpElt603QaduztxN6bm23lGSN7dyp2ddlyhkW
         607Vk2s3O0/VkzKTNoDhAl3d/Wz7W878ITPx8A6CRB9sYZJo3n6RP9LUgBKhkkDpe0JB
         dhtY5yCXm6fs0TRBl9zo5wkvMjQD4oTGzJDsBQUoddix/uAF1cYAcJWUKgv+3g97Zh7I
         N2YA==
X-Gm-Message-State: APjAAAXzVcmS1e56A/Jys+G/jPWmWW8aK9nDGSg/UHwVFguVzF0Qy8Lc
        ziig0berNLF7rrZqU1dWHs8=
X-Google-Smtp-Source: APXvYqwmZlkmx1mhgCYn40rCLu59Po/tB6leuusgEMtreHvtJTa9BmD13/pTMEWfHIERTCB5tPT0mg==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr25050818plb.171.1580749135496;
        Mon, 03 Feb 2020 08:58:55 -0800 (PST)
Received: from jprestwo-test.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.googlemail.com with ESMTPSA id h10sm20579298pfo.181.2020.02.03.08.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Feb 2020 08:58:54 -0800 (PST)
Message-ID: <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Prestwood <prestwoj@gmail.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Mon, 03 Feb 2020 08:54:40 -0800
In-Reply-To: <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

<snip>

> diff --git a/security/keys/trusted-keys/tpm2key.asn1
> b/security/keys/trusted-keys/tpm2key.asn1
> new file mode 100644
> index 000000000000..f930fd812db3
> --- /dev/null
> +++ b/security/keys/trusted-keys/tpm2key.asn1
> @@ -0,0 +1,23 @@
> +---
> +--- Note: This isn't quite the definition in the standard
> +---       However, the Linux asn.1 parser doesn't understand
> +---       [2] EXPLICIT SEQUENCE OF OPTIONAL
> +---       So there's an extra intermediate TPMPolicySequence
> +---       definition to work around this
> +
> +TPMKey ::= SEQUENCE {
> +	type		OBJECT IDENTIFIER ({tpmkey_type}),
> +	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> +	policy		[1] EXPLICIT TPMPolicySequence OPTIONAL,
> +	secret		[2] EXPLICIT OCTET STRING OPTIONAL,
> +	parent		INTEGER ({tpmkey_parent}),
> +	pubkey		OCTET STRING ({tpmkey_pub}),
> +	privkey		OCTET STRING ({tpmkey_priv})
> +	}
> +
> +TPMPolicySequence ::= SEQUENCE OF TPMPolicy
> +
> +TPMPolicy ::= SEQUENCE {
> +	commandCode		[0] EXPLICIT INTEGER ({tpmkey_code}),
> +	commandPolicy		[1] EXPLICIT OCTET STRING
> ({tpmkey_policy})
> +	}

I have been using your set of patches in order to get this ASN.1
parser/definition. I am implementing an asymmetric key parser/type TPM2
keys for enc/dec/sign/verify using keyctl. Note that this
implementation goes in crypto/asymmetric_keys/, and your patches sit in
security/keys/trusted-keys/.

Currently I am just including "../../security/keys/trusted-
keys/{tpm2key.asn1.h,tpm2-policy.h}" in order to use the ASN.1 parser
to verify my keys, but this obviously isn't going to fly.

Do you (or anyone) have any ideas as to how both trusted keys and
asymmetric keys could share this ASN.1 parser/definition? Some common
area that both security and crypto could include? Or maybe there is
some common way the kernel does things like this?

Thanks,
James


