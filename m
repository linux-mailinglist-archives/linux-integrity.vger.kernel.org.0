Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9A280CC
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2019 17:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbfEWPRw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 May 2019 11:17:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32845 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730756AbfEWPRw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 May 2019 11:17:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so5791267otq.0
        for <linux-integrity@vger.kernel.org>; Thu, 23 May 2019 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wDJUsJd4yMhMu+8lxG0FAowua7E3itAD/cx+6Q7CrIA=;
        b=pDmstZFL6qL58FDFItmSu277IRdt+GyIb/cfuJkbKwNd1jkvn8c/J9R7vH2R6tbdAH
         dgTaarloXBdg26oLCI7uRm/+JdTSgSvtJ93Lkj1W2sZ0vtp9H+dx5bGL3uvJiTHi8AIX
         wgX3mnhSbffCFsAyCJVjTtAQ7xgGuiTGPPH+FUqfDCIsWFNRT3jlSf94MVSFql8HSB3u
         MePIAI21MfsF6l0bHm37itkI6AQfMwpbHxMkHLh7I/fkCe3pl38FHHrKwj5wEUQ1ra6D
         mPcWLUPJrhcO3N64XY5JKYyJ34hBWFbdTTq8X/uSGIIgwJAWfhAuH2lbiwkKqarN9o8B
         dMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wDJUsJd4yMhMu+8lxG0FAowua7E3itAD/cx+6Q7CrIA=;
        b=m+K277SFCMZqpXQEYYmr9irSzRN8QftaMRrNoOzQYUx3S3HJgNQaeDAbATavVqRjkH
         Yh9/4daGuTGGH5/jnQGkVi2Z2lm5SzfhCrYki5ZG4mj6Hrvdlf5xZIjt/ZoxnjXNz8IG
         4VaT/iEiP/1EZK1cNsOri+TNXLlNI3QhQ/emgbexCLVZhM1aNq4wcllodvpPHgkDOf6p
         81s6pP0eDXo8qX1G+oJEIymKNTmyZvyzRTyIisNfECg+mFpXFN18/KbZqtQy6ee9rsvn
         9kzrJsbZcyhQeuYQbOdH+zHLaTx1mX3UlL94hzsYqYPwu/3m6OIs23UqKGOJLXaqwWuS
         yMng==
X-Gm-Message-State: APjAAAVGXwGERodQVuuK3iIoUemG3HsGyYblXbjeSrgT4Ylrfku8Gzst
        7bt8l+AMkhu3XmKzOOhuPr+NBXSblgpr4sEBOCzSKA==
X-Google-Smtp-Source: APXvYqyJRk9nRrzwTqq4yaZ+BYgSoWOPb3+W0pYMcFDfL0EMUvpCnY51+MZ4pl9bpOIvHfz1eG5AyNe+gQh1BKgXXd8=
X-Received: by 2002:a9d:5e19:: with SMTP id d25mr10007843oti.316.1558624671893;
 Thu, 23 May 2019 08:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190523122623.25684-1-dbaryshkov@gmail.com> <1558624376.4347.167.camel@linux.ibm.com>
In-Reply-To: <1558624376.4347.167.camel@linux.ibm.com>
From:   Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date:   Thu, 23 May 2019 18:17:39 +0300
Message-ID: <CALT56yOkkR15ZMuxYzDWqvwOWS0pek442m=TK2JQ8EE8fFUxcA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ima-evm-utils: link to libcrypto instead of OpenSSL
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

=D1=87=D1=82, 23 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 18:13, Mimi Zohar <=
zohar@linux.ibm.com>:
>
> On Thu, 2019-05-23 at 15:26 +0300, Dmitry Eremin-Solenikov wrote:
> > There is no need to link to full libssl. evmctl uses functions from
> > libcrypto, so let's link only against that library.
> >
> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>
> Thank you for this patch and the other three.  They're all now in the
> next branch.

Thank you!

--=20
With best wishes
Dmitry
