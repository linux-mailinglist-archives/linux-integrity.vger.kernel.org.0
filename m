Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24C636EF82
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhD2Sio (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 14:38:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60141 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233338AbhD2Sin (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 14:38:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B48E5C00BA;
        Thu, 29 Apr 2021 14:37:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 29 Apr 2021 14:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=fE334WxVv8hggJg7vwgenFsGsP
        oojInS8+Dd3XEtc3c=; b=EBHUZvqMFvH7KYz5N5Nsc6pq3sPwm2SFyoT+4BL/sr
        dWyJ/wuNP8O+D0zXcwWuuVS/PJR7UACm895Y46apg76o3Cp/oieu6+tStsvPhMpJ
        yYtNAHKc1mIdJfiCYFZIT1AZKyEA29VqFUNVPiPa0pT/Q7aN8EgkApiOLe3Uxwii
        yQg84BBTUZjdXsUE69PKSAXdcbCYYJMK/VPFtYop6olqZTtZgUO8Ip5bhs5OUUBX
        ESxXsHLVzeIHf0C/EwT30Kv4rROMBUf4Etrg/+AyVF/k0xHzckda5UK7UYOHzzx8
        FijMsI6k8M0UboXTjE4QupzVSFwUx5F3D9YE7+rx8pTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fE334WxVv8hggJg7v
        wgenFsGsPoojInS8+Dd3XEtc3c=; b=a3I4dd64EIWjXM7+DsxMYngViBp/+E3Rc
        EUoUIZGzLnFk/1Cx7aYokAYjF0GgsqOMPhsE60ThlfOZirNThA/MYYGtlcLi6G6a
        21dsyk9dB1dO4C9WqiIgf5grIRbyTCpsFFOlCXyFKk/UUBIXpmhJt3G9535G1ZY5
        pb1Z5WsMACfHj52q435+y3MaIIDlS4354M4m5xyRHACP62/b01KO/iGezc3ieAo3
        NC3v6njNpiuQTbJjf6SjGC79M7D/RRgTjM45UFkgyFeAgSTwUJTMyfe0lle1yx0x
        IOySktHtIBrPArQ9jHBrD24W0/odibefCUSswrv+/fdtM3IvbBgWQ==
X-ME-Sender: <xms:BP2KYB_XfKFlYUBnxZWsFjSOPG_nbNOnFhQz-vn0OcmJS3IQiAbwBg>
    <xme:BP2KYFuO92VmSQpVDeE1W4mDCiq6QncJXUrvszR0iE0RONSE_WereZFkgPyCFCFWf
    DAnRplb2Pch9zfQ1G8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvgedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuegvnhcuueho
    vggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrghtthgvrh
    hnpedttedvgedvtedugeeikeejfeetueekfefhueeugfekheegjeeuffegfeffgefgueen
    ucfkphepvdegrdduieelrddvtddrvdehheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:BP2KYPC2kfHAX2JGoRqFSMB11vL5vPo7SeWtnBzmyBKRJepjzXQOWw>
    <xmx:BP2KYFfwic8gDemfpI-WNR3GNA4WLAu7l0b7vGrThS1lm05GLA1zTQ>
    <xmx:BP2KYGNDIYqDJ4qPJchRrpm-QeS-AyyLcy9wDk2NrEAz5JaY38bMkA>
    <xmx:BP2KYDq7WKp05zED-IiYOcoeFcnpaP-rFd4XnlHBslkGCItOiWE4RQ>
Received: from localhost (unknown [24.169.20.255])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 14:37:56 -0400 (EDT)
From:   Ben Boeckel <me@benboeckel.net>
To:     keyrings@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 0/1] trusted-keys: match tpm_get_ops on all return paths
Date:   Thu, 29 Apr 2021 14:37:41 -0400
Message-Id: <20210429183742.756766-1-list.lkml.keyrings@me.benboeckel.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

Bug report thread Message-Id: <YIpV9pcyM9/rWqEt@mwanda>

Ben Boeckel (1):
  trusted-keys: match tpm_get_ops on all return paths

 security/keys/trusted-keys/trusted_tpm2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


base-commit: 3644286f6cbcea86f6fa4d308e7ac06bf2a3715a
-- 
2.30.2

