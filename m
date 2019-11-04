Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB54EE75E
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2019 19:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfKDS1k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Nov 2019 13:27:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30494 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727998AbfKDS1k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Nov 2019 13:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572892059;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/bY+CUa85MFWsXMT21zkm2+cAGNPbh1hq9pOgxL54M=;
        b=BB8IhQmN7xEbWxcUqFemKjCMRA9PIV/237Qel8plMCxK7pZdHlPeVJnIVHuesbjO7wsn7j
        kHPvOycY8zR/ZY6/1nJEt1HFkqA+hg5nrXAAvona9lglmu1fy0Ji/bDJELCb/iBOdNrSbo
        0nIRo48RyPNgY0h6chMLRL4gX66r9so=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-XQpfOKcnPKKnQkiD5y7bpA-1; Mon, 04 Nov 2019 13:27:35 -0500
Received: by mail-yw1-f70.google.com with SMTP id u202so14301402ywe.20
        for <linux-integrity@vger.kernel.org>; Mon, 04 Nov 2019 10:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=UQTxF+PaFPipR2copx+bjU1lc1ASC4fYMeWmThU/trw=;
        b=Dtuwto4pSgYQWiPonjCG2kRdBTpFHng7VjpQ1sPhfQ0fMb+i1jZjS/FNu2USX+LYDJ
         OgRVcAv3zB1XGFZI8hya/0MWLjrnEBrpam275gcb+z+uAcMAIVkXNUjpD7szLMwcRVlO
         F+CsbmkaYEgqHWjGjDlQeDRrtWEfD5zh2iK45FjYb19q8ff8zZt46GZvAS6K6vUR1+A/
         KgoHOwZ7vxS+7s7h6GRrh9mo2DGlm/sp5tZjy+CAct0+1QZdBGfHuV39i0uZIxXCUqeg
         7ScBNslWPoI0ATJXx/ClHJGi3kS03GmWjoPDUr0BQodVDi+FgO9BSrUvQs4ygs7WKjWA
         O2eg==
X-Gm-Message-State: APjAAAX16wSSQp2bedNOUer3BAkcGn9iuHTFUMauPJXMhiGTxOhq15Xi
        nGwW2v9GVX5NpdqhDvfI4uOa/Wtm9H4V46E8Ll/6AUdRrQCgbTIdhRQ2wsaUChyvC29ITXAUc9i
        DovFc/xpQKGtKgNZei4X7UZAJjIr5
X-Received: by 2002:a0d:eac4:: with SMTP id t187mr22164090ywe.289.1572892055276;
        Mon, 04 Nov 2019 10:27:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdpTuxN5zO2b1LpcpA/sBM98/9eXP/XljxokAzLo+iqjs7XMEFq0HturX7XVaGKxZSSkh4bA==
X-Received: by 2002:a0d:eac4:: with SMTP id t187mr22164071ywe.289.1572892054979;
        Mon, 04 Nov 2019 10:27:34 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g24sm6158283ywk.94.2019.11.04.10.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:27:34 -0800 (PST)
Date:   Mon, 4 Nov 2019 11:27:32 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] tpm: remove tpm_dev_wq_lock
Message-ID: <20191104182732.md3t6xbumg53wkcl@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20190211105835.16851-1-bigeasy@linutronix.de>
 <20190211141145.GD8431@linux.intel.com>
 <20191010160313.pdf6ue4r2intbgoh@linutronix.de>
 <20191014193942.GH15552@linux.intel.com>
 <20191028202419.GA7214@linux.intel.com>
 <20191028202637.GB7214@linux.intel.com>
 <20191104143957.onsfuvmwfuvmfuu6@linutronix.de>
 <20191104173709.qqmdiacytyimbqhx@cantor>
 <20191104174450.dlxlgixizej5orqr@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20191104174450.dlxlgixizej5orqr@linutronix.de>
X-MC-Unique: XQpfOKcnPKKnQkiD5y7bpA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Nov 04 19, Sebastian Andrzej Siewior wrote:
>On 2019-11-04 10:37:09 [-0700], Jerry Snitselaar wrote:
>> It looks like checkpatch is expecting the word commit to precede the has=
h on the same line.
>> I get no errors with the following:
>
>That would explain it. That is however not what the TIP tree and other
>people do not to mention that reading wise it makes sense to keep the
>word `commit' as part of the sentence and add the hash in the next line.
>

Yes it reads better. What about the following?

Added in commit 9e1b74a63f776 ("tpm: add support for nonblocking
operation"), but never actually used it.

And then add the Fixes: line above the Cc: and Signed-off-by: ?

>> Added in
>>
>>   commit 9e1b74a63f776 ("tpm: add support for nonblocking operation")
>>
>> but never actually used it.
>>
>> Fixes: 9e1b74a63f776 ("tpm: add support for nonblocking operation")
>> Cc: Philip Tricca <philip.b.tricca@intel.com>
>> Cc: Tadeusz Struk <tadeusz.struk@intel.com>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
>Sebastian

