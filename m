Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1352921FC6
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 23:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfEQVjn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 17:39:43 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:43002 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbfEQVjX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 17:39:23 -0400
Received: by mail-vk1-f201.google.com with SMTP id n198so3089089vke.9
        for <linux-integrity@vger.kernel.org>; Fri, 17 May 2019 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CxlinLSdgStAZj8ZYyY8C5jglK14sBrM48vYUM57nQk=;
        b=Lr1hshRLI8bkkP5XQ+UnqbvtSIn4+GxIHNrUKo5knOvGtLVWvllhbmL/P7SFVq0q3G
         oySlkP3VC/FArrDJIA9lERGu11efUk2HE1iv+rtqxt5h25S7olLYbSifqxp2Pm5Sa14n
         eJG55mOsEM7FGWG36vVTPIvS49vJRvB2AnCjRfPc+2yd0Vqq9usi7KTHCKhCd0IyT4PR
         qBfAxm/5OnPt9nlgrr+zu3mJDsmaWzAe27XN5d6ZwKQ4qa8VeYXAmd15kiS/0jyawOr0
         9nYCnuQt/oEVdCzXELQw2AWQANdTpFx0IkvBjyPIam8tKwuieV42gWQlnehz57Ep/F18
         7Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CxlinLSdgStAZj8ZYyY8C5jglK14sBrM48vYUM57nQk=;
        b=C1o8Cu+kdJfIQjJahtUv2VkYPVpDI2mvZMdBZ4lHwWw9MzlHIZUkvrCj57tZSLmBm1
         57Db6TcMyK4PwsVxMYfxZuz2F8rx9bf3a8umIjGZAd7ncBHWAz6CcqiRYNNyP3R72gt2
         4U2sxS/bKAJZTmO9PRz0dFk60p7oKMXYZ+wOy8fKBVygaK/xntZnwMdwnq23X/CigaZZ
         P+SPK5T6hOCpjzU1QIbrBBl2hLHIUt4zuWuwGqzMcDm8IkYRPch8bbq0PTq4f5gCHfHW
         QTYOhAkvqsREFqnHps4TgquXQcnbfMQ7nJiPB7SWH31aPXAfHswDtQWHQZ/9EPxsyYeJ
         Ujvw==
X-Gm-Message-State: APjAAAUSNi26avX5DlZn7VgXK0YJVkPWJB+zkM+eiZ/9a+cPGl0nftV2
        Xcc3fKIJcH1HS9y4A1qW4KKaLul0VAZ5utmS4/BCo58iWgcuZ+PQ70g2CEmGMslu90YG7a2qTVg
        Fe4c1idIcYy30GlpnSSlIqbR0dVwzyffbOwIA9d6hToAq0vqIzQBA6gzcUvtOdhgppGybhPBEz3
        dP5A9EdDdcisKDf38H8DE=
X-Google-Smtp-Source: APXvYqwIDbPWP1gGpGqX0HDPWX3Ohrqk6UfCTZUEHeW8kUGSBX2WSMELoI3iXY6X+cwOujb0YKqTVixq1iTSqpDOz3RSCw==
X-Received: by 2002:ab0:5a07:: with SMTP id l7mr22035272uad.78.1558129161944;
 Fri, 17 May 2019 14:39:21 -0700 (PDT)
Date:   Fri, 17 May 2019 14:39:14 -0700
Message-Id: <20190517213918.26045-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V6 0/4] Add support for crypto agile TPM event logs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Updated with the fixes from Bartosz and the header fixes folded in.
Bartosz, my machine still doesn't generate any final event log entries -
are you able to give this a test and make sure it's good?


