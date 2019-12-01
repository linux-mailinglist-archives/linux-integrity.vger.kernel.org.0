Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C0F10E334
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Dec 2019 19:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfLASms (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 1 Dec 2019 13:42:48 -0500
Received: from mtax.cdmx.gob.mx ([187.141.35.197]:13726 "EHLO mtax.cdmx.gob.mx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfLASmr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Dec 2019 13:42:47 -0500
X-Greylist: delayed 7802 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 13:42:47 EST
X-NAI-Header: Modified by McAfee Email Gateway (4500)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cdmx.gob.mx; s=72359050-3965-11E6-920A-0192F7A2F08E;
        t=1575217651; h=DKIM-Filter:X-Virus-Scanned:
         Content-Type:MIME-Version:Content-Transfer-Encoding:
         Content-Description:Subject:To:From:Date:Message-Id:
         X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-AnalysisOut:X-AnalysisOut:X-SAAS-TrackingID:
         X-NAI-Spam-Flag:X-NAI-Spam-Threshold:X-NAI-Spam-Score:
         X-NAI-Spam-Rules:X-NAI-Spam-Version; bh=M
        8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs4
        8=; b=EU6IHNv2FpJujqYaVqg4S2cikCNlBAYlAYO+A7dwstU/
        il02qJQF68/GXvnmdF9TzPKiOlnmgHAjrYahNMU0x4LtO4fcIu
        4B/ASqmUx6Uq2fKREYv8Ml5/GgClBNctfKP1jdKJSy5mX+mVCF
        7LEVP4Gcfn8agJpuBCmHudplW1M=
Received: from cdmx.gob.mx (correo.cdmx.gob.mx [10.250.108.150]) by mtax.cdmx.gob.mx with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 1dee_65f9_e1920368_f3ad_42ea_8780_5d7dc7ada885;
        Sun, 01 Dec 2019 10:27:30 -0600
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id A8DAF1E2B01;
        Sun,  1 Dec 2019 10:18:52 -0600 (CST)
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wmEwHShxcJgh; Sun,  1 Dec 2019 10:18:52 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 443C51E2FF8;
        Sun,  1 Dec 2019 10:14:21 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx 443C51E2FF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=72359050-3965-11E6-920A-0192F7A2F08E; t=1575216861;
        bh=M8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs48=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Message-Id;
        b=kTmZgGqhdRs9UNMRh7P+YONLCPj75cdgsFrL2r9MvZ4g6YUbFVZ0btbV75BAEE8+b
         QTrG53fjGRyyRNqPP+dZR/os0w9fe9eZU7X18zB8Fimu89weBo9wgUtMAtXRg4F9S3
         V1XDSedRGwLV1av8pJ/3Zk3BZOkom+nn7PNbFtmQ=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UgdLJ73ow-ud; Sun,  1 Dec 2019 10:14:21 -0600 (CST)
Received: from [192.168.0.104] (unknown [188.125.168.160])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 36BEF1E3275;
        Sun,  1 Dec 2019 10:05:42 -0600 (CST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Congratulations
To:     Recipients <aac-styfe@cdmx.gob.mx>
From:   "Bishop Johnr" <aac-styfe@cdmx.gob.mx>
Date:   Sun, 01 Dec 2019 17:05:35 +0100
Message-Id: <20191201160543.36BEF1E3275@cdmx.gob.mx>
X-AnalysisOut: [v=2.2 cv=JYXMlQCV c=1 sm=1 tr=0 p=6K-Ig8iNAUou4E5wYCEA:9 p]
X-AnalysisOut: [=zRI05YRXt28A:10 a=T6zFoIZ12MK39YzkfxrL7A==:117 a=9152RP8M]
X-AnalysisOut: [6GQqDhC/mI/QXQ==:17 a=8nJEP1OIZ-IA:10 a=pxVhFHJ0LMsA:10 a=]
X-AnalysisOut: [pGLkceISAAAA:8 a=wPNLvfGTeEIA:10 a=M8O0W8wq6qAA:10 a=Ygvjr]
X-AnalysisOut: [iKHvHXA2FhpO6d-:22]
X-SAAS-TrackingID: 0f9e3ed5.0.7834648.00-2361.13425677.s12p02m003.mxlogic.net
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 3
X-NAI-Spam-Score: -5000
X-NAI-Spam-Rules: 1 Rules triggered
        WHITELISTED=-5000
X-NAI-Spam-Version: 2.3.0.9418 : core <6686> : inlines <7165> : streams
 <1840193> : uri <2949750>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Money was donated to you by Mr and Mrs Allen and Violet Large, just contact=
 them with this email for more information =


EMail: allenandvioletlargeaward@gmail.com
