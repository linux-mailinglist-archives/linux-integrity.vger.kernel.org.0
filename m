Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701B9197C18
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 14:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgC3Min (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 08:38:43 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:55510 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgC3Min (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 08:38:43 -0400
Received: by mail-wm1-f44.google.com with SMTP id r16so1924700wmg.5
        for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2020 05:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2QP+feFYIL5nAiDCHRcRpa/IkkPk+pnfEwMJOdA4r5U=;
        b=k5c27Zbyzcw7C9FqZsOmZBeQoiFL+kFFDEQHLQpL407YeFnPYsSPx52lkdTH1Uamie
         di/LmONiXGnyaBUg5fzYpTZo+FJP+4dphIucoOieiWdED8/Ui7bCuxxLTxfe60OZzhf1
         eoH33v0udNkKyaO+GFzJX/W+RnjIHBXSfxHKsPw4enL4iJT2qKfZj+oTTajYJ0MnZ/gM
         acK5V9pnhpydVEiX9xwkoqbTQFIMm/wSWvRuqFKmFXj2QaVjrjpqv2DKyXos230IDSy+
         hElGNsucWVn1C24JROMSiZE+oMGKi2T1BHzJGK4tQ7Bvpsj9shEMkotJjZW6h5IcRUPO
         WUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2QP+feFYIL5nAiDCHRcRpa/IkkPk+pnfEwMJOdA4r5U=;
        b=tpaKOjCM9STl5lBauCoBirapXuhJ1ISpnOERy+mcqJ3iCl9QjXGq+NPeGDvT95SnC0
         Q1lXG85Yd/ZUPvkC/aAtFPn8u0UcchQp3WUx0E1FoyPFV7YVZYsAs268GUHn84qo8Ryd
         zintOPfsKYUhXeW6WpZ4LvqtXfgDK0DhndOj+GsISmcy+3i50Bfbh2wSD61zpSLIqKOE
         /MaVZE+7/XWt57wS30ywQHWxQmN0nEUd5yyVDIjWZtIrthJp5cQRbgpjdiOiBkAaHCJD
         9vjTxGoZp8D6Hx/hmKKF8e3BX8uya6VMzANteRVeBCHVOyZlbFYBL9JYEWLzBy15+bEw
         xerw==
X-Gm-Message-State: ANhLgQ0HPx3TI+6fAMDNXGB54MLTa3piKUvd4CsbDv1BvkeKbSHx6/vd
        rk8OXn1M4N/QbMxxAfMvgS36YDOWcXF2yAML+TZRkK4y4J0=
X-Google-Smtp-Source: ADFU+vvPobm8CpzD0ivQdMTQmg6VfUpiXETX43dhJabTbdti5WwoOIWimbAabwZJ+zd8knVx3hHxMhM6QmKH8n/Rb7k=
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr11246748wmk.138.1585571919941;
 Mon, 30 Mar 2020 05:38:39 -0700 (PDT)
MIME-Version: 1.0
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Mon, 30 Mar 2020 15:38:28 +0300
Message-ID: <CAP22eLGQedz3PNXtyteefQD3aGtj9iZQeeZ4SaaQ2Fd87QsG1g@mail.gmail.com>
Subject: Request for help
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi people.
Today I've sent my first patch - Add file suffix selector as an IMA policy rule
My apologies for the possible errors I made fighting with mutt.
I deleted FROM line of the format patch because I thought it is wrong,
here the line:
From b84152f969c6d0555486f3c78e1dd374f05bbe18 Mo Sep 17 00:00:00 2001

Please advise me whether this line is necessary.
