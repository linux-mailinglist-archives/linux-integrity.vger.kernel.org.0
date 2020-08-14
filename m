Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04024463E
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Aug 2020 10:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgHNIOB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Aug 2020 04:14:01 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.2]:39017 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbgHNIOB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Aug 2020 04:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harman.com;
        s=harman2020; t=1597392838; i=@harman.com;
        bh=XjNzQgYHnj5AbPTb6t48hQtzDyaXNCi9P2fFLdemfgY=;
        h=From:To:CC:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=hdI4vxZD5ZqWRbkA9ZqZBIKPeGz8uChO+dcgfZFdi9+HxXZGBX56eVLzikn3ttx90
         K4lDO0Te58GX9s01dmqjDbf4geUDDpp4/WWeIbAk8mlc1klq7F+OGd7oF3b8poD62X
         tthK4O3wbxWg1VG5b3+Cn7kMEDRscG3+QVe8cKPJuC09n6Q8MIIKqH0JtQLtZ7hQzR
         38mFA0YOEiooCxykdIYwiJK9fzI7/hOFsBmtrQsgMNB1rBjCB1YVtb+0HGvKTD4xPk
         5CLoTYLNM8kKnWhA+ZQwACWBAKMuORaR5SCwPZQHY2sNxXBOC68ps9+92e7GtrwBjM
         GDAZf6loNd4xg==
Received: from [100.112.130.0] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.us-west-2.aws.symcld.net id 2F/B2-01971-6C7463F5; Fri, 14 Aug 2020 08:13:58 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRWlGSWpSXmKPExsVyqPAOq+4xd7N
  4g09nGC1OnDvGbnF51xw2ByaPz5vkAhijWDPzkvIrElgzJp/6wl7wV7qidUFIA+NUiS5GLg4h
  gS2MEj/OT2OGc+b0T2WHcA4ySuw7dQIow8nBJmAusWtPCzuILSLgLnHtcS8jiM0s4Chxe+9bJ
  hBbWMBV4v/2lSxdjBxANV4SH+4HQpTrSVy5cACsnEVAVWLTz81gNi/QmP+PF4LZjAJiEt9PrW
  GCGCkucevJfDBbQkBAYsme88wQtqjEy8f/WCFsA4mtS/exQNhyEsu2P4fq1ZO4MXUKG4StLbF
  s4WtmiF2CEidnPgGrFxLQkLh2aCXrBEbRWUjWzULSPgtJ+ywk7QsYWVYxmicVZaZnlOQmZubo
  GhoY6BoaGukaGlnqmhroJVbpJuqVFuuWpxaX6BrpJZYX6xVX5ibnpOjlpZZsYgRGVUpBo9EOx
  r+vP+gdYpTkYFIS5bU2N4sX4kvKT6nMSCzOiC8qzUktPsQow8GhJMGb7QaUEyxKTU+tSMvMAU
  Y4TFqCg0dJhHeFK1Cat7ggMbc4Mx0idYrRnmPj07mLmDkmvASRB4/OA5KXrwNJIZa8/LxUKXH
  enSBTBUDaMkrz4IbCEtIlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8MiBTeDLzSuB2vwI6
  iwnoLL1mU5CzShIRUlINTBFCv0+sCDRN+OS0OdTr9oYLGY7T2LRlHrAVB3p+yrtu218w71naR
  /WGU21/bE4JV/oaMapozq487T7bVch9nVvhDZPP4Vv/1Pl6Cq/qnnU8ZbPvkjPiouo2nbvNJx
  2xf/d/7ez/fAICXnnLelc+zt3aoenJMmHmvic/OY/Ei7TyKlsIyOXuY1k8/3BVYMuy19/Py7a
  YMi5cyZHzdxe3qE6CwPcrrZOVFnPYulzrNjAzi5+36HDNC6k5of8bZpZ0N1gsTnih+EPoze1T
  4rd5JBOy509jWneOtWCDJfeiSyJiW3ecl1i6I6X7aMwf16S4ZP2DW5mvHnla2fXM8PqngraHM
  8XzpQ3YOXXKOrx2KrEUZyQaajEXFScCAHthy/DDAwAA
X-Env-Sender: Vladut.Vranceanu@harman.com
X-Msg-Ref: server-21.tower-322.messagelabs.com!1597392832!48855!2
X-Originating-IP: [194.113.220.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22423 invoked from network); 14 Aug 2020 08:13:57 -0000
Received: from unknown (HELO HIMDWSMB10.ad.harman.com) (194.113.220.5)
  by server-21.tower-322.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 14 Aug 2020 08:13:57 -0000
Received: from HIMDWSMB08.ad.harman.com (10.70.50.118) by
 HIMDWSMB10.ad.harman.com (10.70.50.215) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Aug 2020 10:13:52 +0200
Received: from HIMDWSMB07.ad.harman.com (10.70.50.117) by
 HIMDWSMB08.ad.harman.com (10.70.50.118) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Aug 2020 10:13:52 +0200
Received: from HIMDWSMB07.ad.harman.com ([fe80::4cf8:5ebd:53f7:f6c4]) by
 HIMDWSMB07.ad.harman.com ([fe80::4cf8:5ebd:53f7:f6c4%16]) with mapi id
 15.00.1497.000; Fri, 14 Aug 2020 10:13:52 +0200
From:   "Vranceanu, Vladut" <Vladut.Vranceanu@harman.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [linux-ima-user]Systemd cgroups freezes after activating EVM
Thread-Topic: [linux-ima-user]Systemd cgroups freezes after activating EVM
Thread-Index: AdZyEsnJR1w89j+xSzSLGGMu//7ukA==
Date:   Fri, 14 Aug 2020 08:13:52 +0000
Message-ID: <d7a7b26117dc4129b9750130ba59b93e@HIMDWSMB07.ad.harman.com>
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

I have some questions regarding system freezing at boot after activating EV=
M. I receive this error message:

=A0=A0=A0=A0=A0 systemd[1]: Failed to mount cgroup at /sys/fs/cgroup/system=
: No such file of device.
=A0=A0=A0=A0=A0 [!!!!!] Failed to mount API filesystems, freezing.

I am using Linux kernel 4.19.78 and system v2.34. My aim is to activate IMA=
/EVM with EVM in mode 0x80000006, as per https://www.kernel.org/doc/Documen=
tation/ABI/testing/evm. I have a script running from an initramFS, which do=
es the IMA/EVM setup like the following:

=A0=A0=A0=A0=A0=A0 mount -n -t securityfs securityfs /sys/kernel/security

=A0=A0=A0=A0=A0=A0 (set -e; while read i; do echo $i >&2; echo $i; done) </=
etc/keys/policy >/sys/kernel/security/ima/policy

=A0=A0=A0=A0=A0=A0 ima_id=3D"`awk '/\.ima/ { printf "%d", "0x"$1; }' /proc/=
keys`"
=A0=A0=A0=A0=A0=A0 evmctl import /etc/keys/x509_ima_1.der $ima_id

=A0=A0=A0=A0=A0=A0 evm_id=3D"`awk '/\.evm/ { printf "%d", "0x"$1; }' /proc/=
keys`"
=A0=A0=A0=A0=A0=A0 evmctl import /etc/keys/x509_ima_1.der $evm_id

=A0=A0=A0=A0=A0=A0 cat /etc/keys/kmk | keyctl padd user kmk @u
=A0=A0=A0=A0=A0=A0 keyctl add encrypted evm-key "load `cat /etc/keys/evm-ke=
y`" @u

=A0=A0=A0=A0=A0=A0 echo -2147483642 > /sys/kernel/security/evm

, where the policy is:=20

=A0 =A0=A0=A0dont_appraise fsmagic=3D0x9fa0
=A0=A0=A0=A0 dont_appraise fsmagic=3D0x62656572
=A0=A0=A0=A0 dont_appraise fsmagic=3D0x64626720
=A0=A0=A0=A0 dont_appraise fsmagic=3D0x01021994
=A0=A0=A0=A0 dont_appraise fsmagic=3D0x858458f6
=A0=A0=A0=A0 dont_appraise fsmagic=3D0x1cd1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=20
=A0=A0=A0=A0 dont_appraise fsmagic=3D0x42494e4d
=A0=A0=A0=A0 dont_appraise fsmagic=3D0x73636673
=A0=A0=A0=A0 dont_appraise fsmagic=3D0xf97cff8c

This would be a dummy policy, with which I could still reproduce the issue.

Kernel command line parameters are:

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 bootargs =3D "console=3Dt=
tyS0,921600n1 \
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 debugshell=3D1 printk.disable=
_uart=3D0 rootwait mem=3D1024m \
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 loglevel=3D8 earlycon=3Duart8=
250,mmio32,0x11002000 rootfstype=3Dext4 ima_appraise=3Dlog evm=3Dfix cgroup=
_no_v1=3Dall quiet ";

, where ima_appraise=3Dlog evm=3Dfix should ensure that boot freeze does no=
t occur cause of missing signatures and cgroup_no_v1=3Dall is one of my att=
empts at solving the issue(not needed).

The problem occurs specifically only when running this instruction "echo -2=
147483642 > /sys/kernel/security/evm", of activating EVM. The same setup go=
es through boot fine when leaving that out. Moreover, when doing the instru=
ction in user-space, that also works(though I get some EVM-related kernel m=
essages which, at this point, I'm not sure whether are normal or not).

I would much appreciate any lead to what I could be doing wrong, as it is d=
ifficult for me to trace the problem both for my lack of expertise and the =
way the image is formed. I am not subscribed to this mailing list, as advis=
ed by the FAQ, so please reply to my email individually as well, if you do.

Thank you,
Vlad

P.S.: Already messaged systemd community and the answer was:

systemd is just the messenger here. It tries to mount cgroupfs and that's d=
enied due to some permission problem. We don't know IMA/EVM here. Please co=
ntact the IMA community instead, they might be able to tell you why the ker=
nel would refuse cgroupfs mounts.

cgroupfs is required to be mountable for systemd to work. There's no way ar=
ound that.


