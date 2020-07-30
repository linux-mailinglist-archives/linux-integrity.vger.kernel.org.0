Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C68233230
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 14:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgG3M3W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 08:29:22 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.114]:56989 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729003AbgG3M3U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 08:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harman.com;
        s=harman2020; t=1596112158; i=@harman.com;
        bh=izP9VIafVu5Tf9ST1xZxxm8yNmfdNGdN3/ZvkVQGgx4=;
        h=From:To:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=b8+BNjhrmgAuzy3eKfR6+8rwUT7PfFDWQ9w4vLe/TlYp+cjAklDAlnyns7jCr6mRL
         s03SMifxYNxPvUkx8QJr4ck0/FQeR5SKBAXuc1lXHwZgDmdQKyyZMuTz0uHftEyYxw
         XZpDf3u49egWSx7nRkfT7ePFYp/3wOEll34MIHDeS8RzG8CNrGYqQvoh8SHQywK5az
         ZYtY9o0Z38dzCFdE3f7ui9KAK4bYQ5Z7BtzN6BS7tXJ09FUE/qsv8sipDAjG7XlUKs
         b3zcI0IjUYv8fPNm9pGkvlEiZHX4UgbRy9kooBGXuM4fyl4K48Zo959zEsacDotGzn
         lyTYws09RSflg==
Received: from [100.112.135.148] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-west-2.aws.symcld.net id A5/14-22172-E1DB22F5; Thu, 30 Jul 2020 12:29:18 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRWlGSWpSXmKPExsVyqPAOq67sXqV
  4gx2brC1OnDvG7sDo8XmTXABjFGtmXlJ+RQJrRs80n4K54hVNv9YzNTD2CncxcnEICWxhlLh3
  4AErnPN1yWkWCOcgo8TJn5uBHE4ONgFziV17WthBbBEBd4lrj3sZQWxhAQ+J+Uvns0DEfSUW3
  lgGVaMn0b22lxXEZhFQldjauIe5i5GDgxeo99d/PZAwo4CYxPdTa5hAbGYBcYlbT+aD2RICAh
  JL9pxnhrBFJV4+/scKYRtIbF26jwXClpNYtv05VK+exI2pU9ggbG2JZQtfg/XyCghKnJz5BKx
  eSEBD4tqhlawTGEVmIVk3C0n7LCTts5C0L2BkWcVokVSUmZ5RkpuYmaNraGCga2hopGtobKRr
  ZGKkl1ilm6RXWqxbnlpcogvklhfrFVfmJuek6OWllmxiBEZNSkHLpx2MDW8+6B1ilORgUhLl5
  ehRihfiS8pPqcxILM6ILyrNSS0+xCjDwaEkwZu9CygnWJSanlqRlpkDjGCYtAQHj5IIr+YeoD
  RvcUFibnFmOkTqFKMlx4SXcxcxcxw8Og9IXr4OJIVY8vLzUqXEeS/sBmoQAGnIKM2DGwdLMpc
  YZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfM+B5nCk5lXArf1FdBBTEAHee1RBDmoJBEhJdXA
  lH9yT6JnoPDXnJeTnJmE8oIMV2/hmnjF0bp/am1W9esJi/MV17pvUa04/7jdm8Um6MSBjxO5N
  0bppXD98bi1ryWi6LLP+tSIYt08zqsujxp/z5V3apA3iJ2dcEps6qeHwTxlE+KnzFFcvJPprv
  gZn+S/qkWbAtfPlJ+x2c71yVmuJc/f/c7xSm9ZL1+3atupl7HHztq2LV3auYvHMbbiyv6ft4M
  WiOyt/ce9ffqFQC5Po5eB3Nt+HpdguZTz7d/HgqtCq/X2rXr4Vb6sbqf83pybV2dKFV/z2T1f
  2ar06D4OUUujhIkGjzX29/Kf7/y1zthTpqn+5s1HzB+3FHolyn57YbdcUTHn6Ir1nhwPI5VYi
  jMSDbWYi4oTAbymc/itAwAA
X-Env-Sender: Vladut.Vranceanu@harman.com
X-Msg-Ref: server-32.tower-343.messagelabs.com!1596112155!65499!1
X-Originating-IP: [194.113.220.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25229 invoked from network); 30 Jul 2020 12:29:17 -0000
Received: from unknown (HELO HIMDWSMB09.ad.harman.com) (194.113.220.5)
  by server-32.tower-343.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 30 Jul 2020 12:29:17 -0000
Received: from HIMDWSMB02.ad.harman.com (10.70.50.112) by
 HIMDWSMB09.ad.harman.com (10.70.50.214) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Jul 2020 14:29:14 +0200
Received: from HIMDWSMB07.ad.harman.com (10.70.50.117) by
 HIMDWSMB02.ad.harman.com (10.70.50.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Jul 2020 14:29:14 +0200
Received: from HIMDWSMB07.ad.harman.com ([fe80::4cf8:5ebd:53f7:f6c4]) by
 HIMDWSMB07.ad.harman.com ([fe80::4cf8:5ebd:53f7:f6c4%16]) with mapi id
 15.00.1497.000; Thu, 30 Jul 2020 14:29:14 +0200
From:   "Vranceanu, Vladut" <Vladut.Vranceanu@harman.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: [linux-ima-user]EVM does not permit changes on /proc filesystem
Thread-Topic: [linux-ima-user]EVM does not permit changes on /proc filesystem
Thread-Index: AdZmbPcVjeCvQryxR1mYrcLnWIDpnw==
Date:   Thu, 30 Jul 2020 12:29:14 +0000
Message-ID: <27b55b6ae1c347c7a29aefbf62e32e7e@HIMDWSMB07.ad.harman.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.70.50.4]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I have encountered this problem in which I cannot do (for example) chown on=
 the /proc filesystem, operation which fails with Operation not permitted a=
nd kernel logging: audit type=3D1801 audit(1596110664.495:49): pid=3D96959 =
uid=3D0 auid=3D1000 ses=3D4 subj=3D=3Dunconfined op=3Dappraise_metadata cau=
se=3Dunknown comm=3D"chown" name=3D"dev" dev=3D"proc" ino=3D4026532012 res=
=3D0.=20

       root@ubuntu:/# chown root:root /proc/net/dev; dmesg | tail -1
       chown: changing ownership of '/proc/net/dev': Operation not permitte=
d
       [10053.911258] audit: type=3D1801 audit(1596111210.774:52): pid=3D11=
2577 uid=3D0 auid=3D1000 ses=3D4 subj=3D=3Dunconfined op=3Dappraise_metadat=
a cause=3Dunknown comm=3D"chown" name=3D"dev" dev=3D"proc" ino=3D4026532012=
 res=3D0

My ima setup script is:

       mount -n -t securityfs securityfs /sys/kernel/security

       (set -e; while read i; do echo $i >&2; echo $i; done) </etc/keys/pol=
icy >/sys/kernel/security/ima/policy

       ima_id=3D"`awk '/\.ima/ { printf "%d", "0x"$1; }' /proc/keys`"
       evmctl import /etc/keys/x509_ima_1.der $ima_id

       evm_id=3D"`awk '/\.evm/ { printf "%d", "0x"$1; }' /proc/keys`"
       evmctl import /etc/keys/x509_ima_1.der $evm_id

       cat /etc/keys/kmk | keyctl padd user kmk @u
       keyctl add encrypted evm-key "load `cat /etc/keys/evm-key`" @u

       echo "1" > /sys/kernel/security/evm

, where policy is:

       dont_appraise fsmagic=3D0x9fa0
       dont_appraise fsmagic=3D0x62656572
       dont_appraise fsmagic=3D0x64626720
       dont_appraise fsmagic=3D0x01021994
       dont_appraise fsmagic=3D0x858458f6
       dont_appraise fsmagic=3D0x1cd1
       dont_appraise fsmagic=3D0x42494e4d
       dont_appraise fsmagic=3D0x73636673
       dont_appraise fsmagic=3D0xf97cff8c

Kernel cmdline is:=A0 BOOT_IMAGE=3D/boot/vmlinuz-5.5.10 root=3DUUID=3D40d71=
31c-1a9b-4d0f-9757-01a5d1819909 ro find_preseed=3D/preseed.cfg auto nopromp=
t priority=3Dcritical locale=3Den_US ima_appraise=3Dfix quiet, into which I=
 only added ima_appraise=3Dfix/log.
I'm using Ubuntu on 5.5.10 kernel, but I found this originally on Linux 4.9=
, on dev environment.

I want to mention I don't have a deep understanding on the Linux kernel or =
usage, in general, and I am not aware on what else might be causing(or inte=
rfering with) this behavior. My understanding is that IMA should not apprai=
se anything(as I left out any appraisal rule out of the policy for reproduc=
ing this), but explicitly instructed not to appraise those filesystems, whe=
reas EVM does appraise on /proc when it shouldn't. I could speculate and tr=
y trace the problem in the IMA module, but I think the sensible thing to do=
 is to ask if this is something common(as in, I'm doing something really du=
mb) or at least solvable, but I could not find anything related to the /pro=
c filesystem IMA problems. Problem is not there when EVM is not active( or =
is on fix mode).

Thank you,
Vlad

