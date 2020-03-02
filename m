Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5100B17636A
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2020 20:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgCBTFh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Mar 2020 14:05:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39015 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBTFg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Mar 2020 14:05:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id s2so268027pgv.6;
        Mon, 02 Mar 2020 11:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esuw7U2FE0e3pYIvYfD1yXI3wEQn68uhOSyyEHeSXF8=;
        b=l9QalrK/RprPYztikGcXCQtBZf5ZDDumv3bnDJOrRTjLeKhb3a9dFxLx7kzP0nUUqs
         TWR8we+f7WrV0+qFV6tJ6PD9q4fNPz8SCU88+2bcs2VT6qEyDXEMuZ5waj/+8VKHkJPR
         wLMcrLcqqJ2VKc32XJFdqN6jM6mxKM0e4ePyjkloHlDOevRPFZwJLsfvIUWYV++R93tR
         JI+eUpLGxVDTzAb20F6z8DkesSGnlqqlcJFVnRgyIRw9flTDK4nrkkIzeXsVw/2MBIRH
         occMIj3l0U9gFJ3FbM8Bg4huBp04Sk4WwlUvt4MAfeUmXu2ajLxX1hYbfAGsqW0F1ZAB
         Ob5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esuw7U2FE0e3pYIvYfD1yXI3wEQn68uhOSyyEHeSXF8=;
        b=FACHE97WPq6fE/CbBuVhsi160eSTUCAz/PSUt6jj9qH0WZNTV809A3eqeWChSbGqrD
         fFj6WpCziaVBeoGYb0Ic1RYXHwjO3iDB8wcTFSTulMilODGJ7IkPZIn12eC8+xyosto/
         eesef+kaoLxlUxBzkbNxWm2lxYFgfilarSCBklQtFIV9rBML1hlRXR0963zFqO4VsoF1
         V+lhA/qhomX/BSx8meOsn8GqbSo8D/7ZOU+GkJz1gvDU02xWRr/xY2NUnVL7kL56VN+/
         WOFIc/2JIHaLQ4afvo1LZEdyXP1pZfEcRFdDgawLB2jN2dEjXFFRLEI/2Btkor0WrjRQ
         Ba4w==
X-Gm-Message-State: ANhLgQ30qD2HcMj9nwjhxLMOQHdMHuZMVEUPaKHom0t5XtxlARLTudrd
        PH1DzbzuU/3lXS7SREP6bDM=
X-Google-Smtp-Source: ADFU+vsQonHmhjbJfPY/k+/wTLf99UzFSo/Wi+HMTOQ6iO7Rt92t7qrZjgZedgs9s05Vh9DtVRPkrA==
X-Received: by 2002:a63:ad42:: with SMTP id y2mr300993pgo.445.1583175934117;
        Mon, 02 Mar 2020 11:05:34 -0800 (PST)
Received: from jprestwo-test.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.googlemail.com with ESMTPSA id x18sm10020729pfo.148.2020.03.02.11.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 11:05:32 -0800 (PST)
Message-ID: <0795de67c8b9fc3a22beb61a327d1a5397a978c4.camel@gmail.com>
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Prestwood <prestwoj@gmail.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Mon, 02 Mar 2020 11:00:54 -0800
In-Reply-To: <1582834760.18538.15.camel@HansenPartnership.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
         <1582761736.4245.12.camel@HansenPartnership.com>
         <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
         <1582764844.4245.29.camel@HansenPartnership.com>
         <17e025e222cb6aefb5680d6cdad64a9ecf76fa97.camel@gmail.com>
         <1582834760.18538.15.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

> > > 
> > > There's a related patch that introduces HMAC and encryption
> > > sessions for pretty much everything in the TPM:
> > > 
> > > 
> > 
> > 
https://lore.kernel.org/r/1568031408.6613.29.camel@HansenPartnership
> > .
> > com
> > > 
> > > I didn't resend this time around because of patch overload, and
> > > anyway, the last patch needs updating for the current policy c
> > 

You had mentioned the need for updating, but these (or at least patch
1) failed to apply to v5.5. Looks like some headers had been shifted
around since then. Could you rebase these when you get a chance? That
way I can refactor my patches to use your session stuff.

Its hard to to be completely certain but I think all I need is patch
6/12. If that could be made to be a standalone patch and not depend on
the previous sets that could work too.

Thanks,
James

