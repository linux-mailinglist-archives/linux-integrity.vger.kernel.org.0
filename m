Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115948B051
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 08:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfHMG6E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Aug 2019 02:58:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35620 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfHMG6E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Aug 2019 02:58:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id w20so105943342edd.2;
        Mon, 12 Aug 2019 23:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6clqX/GVRjqbh5VWBalBjmQ4fpsDd0SBiJaQ5yYYQNY=;
        b=OXoYSAKbRE0i+wzKkGALiDLIQtX3BdCMtg7habSvTsAZXrtPt9ZOM3q4gp4LwpBuwF
         vxnJVNHGenP3V99IM7Il7ZuotblSO0TjBhdb3zU7EXKsuSUmfTfveJ6DO/TRCv/3z+0F
         K+4J+oqmVEfPxPcDjzcWdtL6bzfQMcDjtDW1INsUeNyEZxtlhTXw5qI2Spo2HQ6wEjvX
         wVrEa1saoQzgAR/N6GUC9hadbT9oipyIwwPW7aDt/kjH7pnZuqZlmr5IURs9lIV8z6kj
         6jSWf0+suTlrX47tfmJFHZKpO6UnJicLa4iQ1zekoKjPQzx+7zJ1fb7lFBZe4WVt7uzx
         V49Q==
X-Gm-Message-State: APjAAAXoeMrmK95FfyuU94FID2IpvDbO1fpqoSBhz1WFPKTZ51xx3DII
        UMLA7vS1NjWXwy3Kf6u1zQP7J8VIL38=
X-Google-Smtp-Source: APXvYqwY7oR4gKkJp2F88JWCL6jbjM5qJqzfAR7s5WDUijWol9n1ByPQwAP/IzTmTuqAIYZD0QcJRQ==
X-Received: by 2002:a50:f702:: with SMTP id g2mr5664150edn.261.1565679482759;
        Mon, 12 Aug 2019 23:58:02 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id v6sm17822998ejx.28.2019.08.12.23.58.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:58:02 -0700 (PDT)
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
To:     linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Denis Kenzior <denkenz@gmail.com>, efremov@linux.com
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212705.26837-1-joe@perches.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <7152d1c2-14bc-87ae-618b-830a1fa008b0@linux.com>
Date:   Tue, 13 Aug 2019 09:57:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190325212705.26837-1-joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi All,

Initially, I've prepared a patch and only after found this discussion. So, please,
look at this patch no more than just a simple reminder that get_maintainers.pl
still emits this warning.

Thanks,
Denis

------------------------ >8 ------------------------
Subject: [PATCH] MAINTAINERS: keys: Update path to trusted.h

Update MAINTAINERS record to reflect that trusted.h
was moved to a different directory.

Cc: Denis Kenzior <denkenz@gmail.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
Fixes: 22447981fc05 ("KEYS: Move trusted.h to include/keys [ver #2]")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d213e192626..eeeb4097d5bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8920,7 +8920,7 @@ S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
 F:	security/keys/trusted.c
-F:	security/keys/trusted.h
+F:	include/keys/trusted.h
 
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
-- 
2.21.0


