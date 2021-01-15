Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C288B2F7393
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 08:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbhAOHRs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 02:17:48 -0500
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:38852
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727174AbhAOHRr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 02:17:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvQpef8sUe3Kg4yM1LqytU3l+PDqeaf67Oby0MVJxtNsfzXjC+wQ5YKix5klxIEFLMqVOGGxgTYkqsqVOdGllWx5qP+yjcGxQEA9gqTm+X3S2ok3Lo64oAqJ/HGVF63WjLMT9caNFvQvDIMIWJTtUEQ42Drc1D5c1JdrUGZqe4boIKwqyH83h4b+M2LtiAk0UM1K26rWzbRx15v9QL2UnUA0vEI0zBlW/JOH5OKbsy8j8TPlJTqUynGXSReNkB2QlqOk0QZ6LCS610zPLenO5IBJkNHAsziaJNYSSu5Jjecpjsj1GZiYUa7aAGiv0ymlwiwGO5CojNJPPJKG2O5J3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jw4pkyTzx8Nw+LHW7lnXCIoymb9FbHJd7faytF48aE=;
 b=DJNOspadusdLMD7xVfkXEdZOFRDCFMtDmpAJ/VxFAlDipJd4aISqPGASBpb/k3zavm9Cy4o3ozPPmGocwrEsgwDewwNqArtDrg+Ky2fuZbgYVBIPpa2I6XKzgo4vd2shY6dLbiYrxNOj/TY3W8m/6gA1hmMaBg+C+p02wd2elBk3UQZqN29UTti3i1DC/N+RJ3utnhpkpr8wDn7i29FZiyfXnuUnw15Vp7gVLdl/aYkIC8BS0anCjcNbGHu6D7zDsdFaUo1vubFZ7Wp3/toYVmVzJkTsYxwYP1LqQ7aUYl37GsMRSYvKDfdPjND7n9Z4Y3U9C0RskEkduXy0mLJ8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siemens.onmicrosoft.com; s=selector1-siemens-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jw4pkyTzx8Nw+LHW7lnXCIoymb9FbHJd7faytF48aE=;
 b=LgQ6EDUItSDZoYoyy9NddFdTZ0E5v+uNLBHmXi73XqSytQhyZFoe8LHLP8U++Tr2RnwaQKI/Ll5D03nvctR386n5DDAg0qjU9kaZT+Hfpv5HlCTIJ0miIILaTP9oo2cU8xyXpNc4idAqlBLOAxA/uLyQVaoBB+i7M6oTxMSZH9U=
Received: from VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:d2::22)
 by VI1PR1001MB1152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:6c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 15 Jan
 2021 07:17:02 +0000
Received: from VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bc45:b6c:8cb5:b9f4]) by VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bc45:b6c:8cb5:b9f4%3]) with mapi id 15.20.3763.012; Fri, 15 Jan 2021
 07:17:02 +0000
From:   "florian.manoel@siemens.com" <florian.manoel@siemens.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "Fuchs, Andreas" <andreas.fuchs@sit.fraunhofer.de>,
        "Peter.Huewe@infineon.com" <Peter.Huewe@infineon.com>
Subject: AW: TPM V2: kernel panic on linux reboot
Thread-Topic: TPM V2: kernel panic on linux reboot
Thread-Index: AdbrC5vRfY3emgdzQJCNnKjYyzhKVAAAgKhw
Date:   Fri, 15 Jan 2021 07:17:01 +0000
Message-ID: <VI1PR10MB2559EA5D0EC208129AA503F684A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR10MB2559EB47FE26FA85EB4B4D4484A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VI1PR10MB2559EB47FE26FA85EB4B4D4484A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-01-15T07:16:59Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=036c5a56-a570-40ae-bbe8-79c2a8e028e9;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=siemens.com;
x-originating-ip: [165.225.26.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33889d4a-8b7d-41e9-58ee-08d8b9258e0e
x-ms-traffictypediagnostic: VI1PR1001MB1152:
x-microsoft-antispam-prvs: <VI1PR1001MB1152E69FD76100D8F549B67A84A70@VI1PR1001MB1152.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4uyTfza7FJ8txFxHIkgTEeRSNKWMl/B2+uVhlsi9tR4EHhcrzZwxkwLqYECYGAN1d6O0v5QZz7q0jXrtqYvdFuDH9cgbfWWJN+3QEw85NxpUsU+2XD5Gl0zfhFdcqNyq/yIXSY9SW6GQGREOKuPn9ecFzKC0iQE+eQWF/9RBWXMWWG/Ely661Xz0IzWuVzOltnA1nQ1hJEQHWyPD0Hn+jlH5K9lQXiTfGkXmwTF8pzW3T6fS6KULRu7WtIvQ+iTeR0FrBmUog9Kq4Iec9/Ev5Q49R4JzfueYXpKfM7Xhzd25EyedLbe6gIUv14RFQSBr93gQuIhUJlfen0o7jpwrxyGJxePKkuLXndYO2KyV+ek0KbCsyvUkcphG5xp2kLyoIc47FeUgyNOymfAl2ZhwhgZUMyyjXZXB5KUFcQW+oa1fiLfp4s4iN2s7UlkbuBki7dyad+rOWZl3NsgH6Rh2qtctD8xSAq2PAb1fk7wXNbmt3+tDjy6S2+pLaS1rUK/6PPYdj7b4kvLpfve/OQh0yQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(8936002)(66476007)(5660300002)(966005)(66574015)(66946007)(55236004)(83380400001)(9686003)(6916009)(8676002)(2906002)(478600001)(30864003)(6506007)(7696005)(76116006)(66556008)(64756008)(26005)(55016002)(86362001)(52536014)(316002)(186003)(71200400001)(54906003)(2940100002)(33656002)(66446008)(45080400002)(4326008)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?diqs0dPwJaDlm/kd5CL1GhRmwFNxz9i/pvL9+IqXAdsFR7ZziZg6oPmxXW?=
 =?iso-8859-1?Q?AvY2A9WbeOhuTwAdRmEBpQIJdQmCbuqDkiU3sHXayvRlcTbIhiieLzIgTz?=
 =?iso-8859-1?Q?pw/nTaP/HEo8Ttk/QxwE5jPoBr6tq62N2iVL857GMIo+cl1emgzGU4GgQs?=
 =?iso-8859-1?Q?ED/Ll/HefjhU7lUS/c2glJdPGW7xcMC2A5NQfBCEiPJegWptFILgmyu8Bw?=
 =?iso-8859-1?Q?oBF08kUliZqoyeI3UXyfWnUyJYUmuZS4DMtU4lHGb6Q7KwGnZy8iA0aGH7?=
 =?iso-8859-1?Q?ld+/VRmsVBIOJSutuhLDf8/slGymPqt60MAI707nJ3nvl1fKOqnbl+bakC?=
 =?iso-8859-1?Q?+QCHfBAoWqstrflkrmDazDeqCAwKKcIxe58t9gvxxknW7UAVjcdP+IuTdZ?=
 =?iso-8859-1?Q?it+9YgaujdGuXhJj8CA3R9DQjcAyI5IXE5OOcRpn8gIB3xYpNbff0KCSb1?=
 =?iso-8859-1?Q?SVpB4URp0JnSi37fs/H6sxg4sYeyM1jL6S0ysOQi1JypnOsl9827pbEROj?=
 =?iso-8859-1?Q?mybFkP7nXaRmZ9JiHGNyqBTVM/R5UGEB2Lf5TB+p9bhSnLsvnn3WBDSC9s?=
 =?iso-8859-1?Q?NWWE7u07yblHt8Z3tOspELT0NTBbZlgKeIIKcPuH17Xdb/C810LsLojAyH?=
 =?iso-8859-1?Q?Xbu29SFVgvvVhckyCdKULvvDU2+ytzd7O3zjCZ4/eUauWr5buHKYZ/aE6z?=
 =?iso-8859-1?Q?f2SUakUwOa/OR23ppIpFxPInCamlBv0RpI+FmnVkPStBJKtgsALOFcB01g?=
 =?iso-8859-1?Q?TnQGZCk1hvO1oB2Vz6Sw8laBvVtYZFORJvbjmNgwTu72NO1xspx4snOpWt?=
 =?iso-8859-1?Q?Lf0gG1zbhHLAAhbZjivXu+vvyrjPGvRiPLZDcTs0ZqNUfbPlC27hEWw7jK?=
 =?iso-8859-1?Q?HnST1valQHF0zqROOSLXGnwVpFckmnHytP7BEpcWWImLfNI0b72z/SzrOG?=
 =?iso-8859-1?Q?3YOsXboE7MY+bLwlDOLhngnsbasIqc52KpMpxNlXBcoKCv0o5i0F4+9jvK?=
 =?iso-8859-1?Q?UvOUGBa4YQRQWPXG4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 33889d4a-8b7d-41e9-58ee-08d8b9258e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 07:17:01.4432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIJoN0BT8mmGrySf9HUotIhpfIyhTk1G0UGOSooIooRmJbvpNCSdEF9+R5qBDUwogeEau/KLNjT+kWLseGG1s4RvB3glT0vbQJSQRULluJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1152
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi,

this is my first post on this mailing list, so I briefly introduce myself. =
I am Florian Mano=EBl, working at Siemens in Germany.
I am currently on charge to implement a TPM V2 (Infineon slb9670, SPI conne=
cted) on our custom board, named 'LPE9403', equipped with a processor 64-bi=
t ARM NXP LS1043a.
I already made some adjustment (defconfig in U-Boot and Linux, device tree,=
 init code in U-Boot).
I have installed "tpm2-tools" using 'apt-get install'. I get to the point w=
here the TPM is correctly detected and I can use some of the function like =
tpm2_getrandom().

However, when I execute the command 'reboot', it leads every time to a kern=
el panic. The logs seems to indicate that something went wrong with the shu=
tdown of the TPM.
In the first time, I wrote to the mailing list of 'tpm2-tools' and got redi=
rected here.
Can you provide me support to fix this issue ?
My config :
- Processor 64-bit ARM NXP LS1043a
- TPM V2 Infineon slb9670
- linux kernel version: 4.19.144

Below the logs of the Linux boot + kernel panic :
"
Starting kernel ...

[=A0=A0=A0 0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034=
]
[=A0=A0=A0 0.000000] Linux version 4.19.144-audis-std (builder@isar) (gcc v=
ersion 8.3.0 (Debian 8.3.0-2)) #1 SMP PREEMPT Wed Dec 2 12:18:57 UTC 2020
[=A0=A0=A0 0.000000] Machine model: Siemens LPE9403

/*
Non relevant logs removed
*/

[=A0=A0=A0 2.240475] fsl-dspi 2100000.spi: registered master spi3
[=A0=A0=A0 2.245980] spi spi3.3: setup mode 0, 8 bits/w, 18500000 Hz max --=
> 0
[=A0=A0=A0 2.258637] tpm_tis_spi spi3.3: 2.0 TPM (device-id 0x1B, rev-id 22=
)
[=A0=A0=A0 2.264946] random: fast init done
[=A0=A0=A0 2.289984] fsl-dspi 2100000.spi: registered child spi3.3

/*
Non relevant logs removed
*/

Debian GNU/Linux 10 lpe9403-VPM7001303 ttyS0

lpe9403-VPM7001303 login: admin
Last login: Tue Nov 16 02:12:25 UTC 2021 on ttyS0
Linux lpe9403-VPM7001303 4.19.144-audis-std #1 SMP PREEMPT Wed Dec 2 12:18:=
57 UTC 2020 aarch64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.

admin@lpe9403-VPM7001303:~$ sudo reboot
=A0=A0=A0=A0=A0=A0=A0=A0 Stoppin[=A0 OK=A0 ] Stopped target Graphical Inter=
face.
[=A0 OK=A0 ] Stopped Daily Cleanup of Temporary Directories.
[ =A0OK=A0 ] Stopped Syncronise system .ardware clock every 5 minutes.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping watchdog daemon...
[=A0 OK=A0 ] Stopped Serial Getty on ttyS0.
[=A0 OK=A0 ] Stopped Wait for ntpd to synchronize system clock.
[=A0 OK=A0 ] Stopped Session 1 of user admin.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping User Manager for UID 1000...
[=A0 OK=A0 ] Removed slice system-serial\x2dgetty.slice.
[=A0 OK=A0 ] Stopped User Manager for UID 1000.
[=A0 OK=A0 ] Stopped watchdog daemon.
[=A0 OK=A0 ] Stopped target Multi-User System.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping DCP daemon...
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Login Service...
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Event Manager service...
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping OpenBSD Secure Shell server...
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping SFP daemon...
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Link Layer Discovery Protocol Agent Daemo=
n....
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Simple Network Ma.ent Protocol (SNMP) Dae=
mon....
[=A0 OK=A0 ] Stopped target Login Prompts.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Getty on tty1...
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Temperature Monitor service...
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Network Time Service...
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Docker Application Container Engine...
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Fail2Ban Service...
[=A0 OK=A0 ] Stopped Firmware Update Confirmation.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping User Runtime Directory /run/user/1000...
[=A0 OK=A0 ] Unmounted /run/user/1000.
[=A0 OK=A0 ] Stopped Login Service.
[=A0 OK=A0 ] Stopped Temperature Monitor service.
[=A0 OK=A0 ] Stopped SFP daemon.
[=A0 OK=A0 ] Stopped Event Manager service.
[=A0 OK=A0 ] Stopped DCP daemon.
[=A0 OK=A0 ] Stopped Link Layer Discovery Protocol Agent Daemon..
[=A0 OK=A0 ] Stopped Simple Network Man.ement Protocol (SNMP) Daemon..
[=A0 OK=A0 ] Stopped Getty on tty1.
[=A0 OK=A0 ] Stopped Network Time Service.
[=A0 OK=A0 ] Stopped OpenBSD Secure Shell server.
[=A0 OK=A0 ] Stopped Docker Application Container Engine.
[=A0 OK=A0 ] Stopped User Runtime Directory /run/user/1000.
[=A0 OK=A0 ] Removed slice User Slice of UID 1000.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping containerd container runtime...
[=A0 OK=A0 ] Stopped target Network is Online.
[=A0 OK=A0 ] Stopped target Host and Network Name Lookups.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Permit User Sessions...
[=A0 OK=A0 ] Removed slice system-getty.slice.
[=A0 OK=A0 ] Stopped containerd container runtime.
[=A0 OK=A0 ] Stopped Permit User Sessions.
[=A0 OK=A0 ] Stopped Fail2Ban Service.
[=A0 OK=A0 ] Stopped target Remote File Systems.
[=A0 OK=A0 ] Stopped target Network.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Network Name Resolution...
[=A0 OK=A0 ] Stopped Network Name Resolution.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Network Service...
[=A0 OK=A0 ] Stopped Network Service.
[=A0 OK=A0 ] Stopped target Network (Pre).
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping firewalld - dynamic firewall daemon...
[=A0 OK=A0 ] Stopped firewalld - dynamic firewall daemon.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping D-Bus System Message Bus...
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Authorization Manager...
[=A0 OK=A0 ] Stopped D-Bus System Message Bus.
[=A0 OK=A0 ] Stopped Authorization Manager.
[=A0 OK=A0 ] Stopped target Basic System.
[=A0 OK=A0 ] Stopped target Slices.
[=A0 OK=A0 ] Removed slice User and Session Slice.
[=A0 OK=A0 ] Stopped target Sockets.
[=A0 OK=A0 ] Closed lldpad.socket.
[=A0 OK=A0 ] Closed Docker Socket for the API.
[=A0 OK=A0 ] Closed sfw_manager socket listener.
[=A0 OK=A0 ] Closed SWUpdate socket listener.
[=A0 OK=A0 ] Stopped target Paths.
[=A0 OK=A0 ] Closed D-Bus System Message Bus Socket.
[=A0 OK=A0 ] Stopped target System Initialization.
[=A0 OK=A0 ] Stopped target Swap.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Update UTMP about System Boot/Shutdown...
[=A0 OK=A0 ] Stopped Apply Kernel Variables.
=A0=A0=A0=A0=A0=A0=A0=A0 Stopping Load/Save Random Seed...
[=A0 OK=A0 ] Stopped target Local Encrypted Volumes.
[=A0 OK=A0 ] Stopped Dispatch Password .ts to Console Directory Watch.
[=A0 OK=A0 ] Stopped Forward Password R.uests to Wall Directory Watch.
[=A0 OK=A0 ] Stopped Load Kernel Modules.
[=A0 OK=A0 ] Stopped Load/Save Random Seed.
[=A0 OK=A0 ] Stopped Update UTMP about System Boot/Shutdown.
[=A0 OK=A0 ] Stopped Create Volatile Files and Directories.
[=A0 OK=A0 ] Stopped target Local File Systems.
=A0=A0=A0=A0=A0=A0=A0=A0 Unmounting /etc...
=A0=A0=A0=A0=A0=A0=A0=A0 Unmounting Home mount userdata...
=A0=A0=A0=A0=A0=A0=A0=A0 Unmounting /var/log...
[=A0 OK=A0 ] Unmounted /etc.
[=A0 OK=A0 ] Unmounted Home mount userdata.
[=A0 OK=A0 ] Unmounted /var/log.
=A0=A0=A0=A0=A0=A0=A0=A0 Unmounting /userdata...
[=A0 OK=A0 ] Unmounted /userdata.
[=A0 OK=A0 ] Reached target Unmount All Filesystems.
[=A0 OK=A0 ] Stopped target Local File Systems (Pre).
[=A0 OK=A0 ] Stopped Create Static Device Nodes in /dev.
[=A0 OK=A0 ] Stopped Create System Users.
[=A0 OK=A0 ] Stopped Remount Root and Kernel File Systems.
[=A0 OK=A0 ] Reached target Shutdown.
[=A0 OK=A0 ] Reached target Final Step.
[=A0 OK=A0 ] Started Reboot.
[=A0 OK=A0 ] Reached target Reboot.
[=A0 675.609520] watchdog: watchdog0: watchdog did not stop!
[=A0 675.618665] systemd-shutdow: 24 output lines suppressed due to ratelim=
iting
[=A0 675.662848] systemd-shutdown[1]: Syncing filesystems and block devices=
.
[=A0 675.672034] systemd-shutdown[1]: Sending SIGTERM to remaining processe=
s...
[=A0 675.686963] systemd-journald[233]: Received SIGTERM from PID 1 (system=
d-shutdow).
[=A0 675.730174] systemd-shutdown[1]: Sending SIGKILL to remaining processe=
s...
[=A0 675.743123] systemd-shutdown[1]: Hardware watchdog 'GPIO Watchdog', ve=
rsion 0
[=A0 675.752565] systemd-shutdown[1]: Unmounting file systems.
[=A0 675.760922] [1021]: Remounting '/' read-only in with options '(null)'.
[=A0 675.782087] EXT4-fs (mmcblk0p1): re-mounted. Opts: (null)
[=A0 675.795819] systemd-shutdown[1]: All filesystems unmounted.
[=A0 675.801420] systemd-shutdown[1]: Deactivating swaps.
[=A0 675.806725] systemd-shutdown[1]: All swaps deactivated.
[=A0 675.811975] systemd-shutdown[1]: Detaching loop devices.
[=A0 675.820775] systemd-shutdown[1]: All loop devices detached.
[=A0 675.895298] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000058
[=A0 675.904126] Mem abort info:
[=A0 675.906933]=A0=A0 ESR =3D 0x96000005
[=A0 675.909995]=A0=A0 Exception class =3D DABT (current EL), IL =3D 32 bit=
s
[=A0 675.915924]=A0=A0 SET =3D 0, FnV =3D 0
[=A0 675.918989]=A0=A0 EA =3D 0, S1PTW =3D 0
[=A0 675.922138] Data abort info:
[=A0 675.925012]=A0=A0 ISV =3D 0, ISS =3D 0x00000005
[=A0 675.928856]=A0=A0 CM =3D 0, WnR =3D 0
[=A0 675.931830] user pgtable: 4k pages, 39-bit VAs, pgdp =3D 00000000bec7a=
5cc
[=A0 675.938447] [0000000000000058] pgd=3D0000000000000000, pud=3D000000000=
0000000
[=A0 675.945244] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[=A0 675.950807] Modules linked in: ipt_MASQUERADE(E) nf_conntrack_netlink(=
E) xt_addrtype(E) br_netfilter(E) xt_tcpudp(E) ip6t_rpfilter(E) ip6t_REJECT=
(E) nf_reject_ipv6(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_conntrack(E) nft_c=
ounter(E) nft_chain_nat_ipv6(E) nf_nat_ipv6(E) nft_chain_route_ipv6(E) nft_=
chain_nat_ipv4(E) nf_nat_ipv4(E) nf_nat(E) nft_chain_route_ipv4(E) nf_connt=
rack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) ip6_tables(E) nft_compat(E) nf_=
tables(E) nfnetlink(E) audis_info(OE) ip_tables(E) x_tables(E)
[=A0 675.995303] Process systemd-shutdow (pid: 1, stack limit =3D 0x0000000=
010d499d8)
[=A0 676.002518] CPU: 0 PID: 1 Comm: systemd-shutdow Tainted: G=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 OE=A0=A0=A0=A0 4.19.144-audis-std #1
[=A0 676.011379] Hardware name: Siemens LPE9403 (DT)
[=A0 676.015902] pstate: 40000005 (nZcv daif -PAN -UAO)
[=A0 676.020692] pc : tpm_transmit+0x148/0x678
[=A0 676.024692] lr : tpm_transmit+0x3b4/0x678
[=A0 676.028691] sp : ffffff800803b840
[=A0 676.031996] x29: ffffff800803b840 x28: 0000000000000000=20
[=A0 676.037300] x27: 0000000000000000 x26: 000000000000000c=20
[=A0 676.042604] x25: ffffff8008d1c508 x24: 0000000000000014=20
[=A0 676.047908] x23: 0000000000001000 x22: ffffffc874d37000=20
[=A0 676.053212] x21: 0000000000001000 x20: 0000000000000145=20
[=A0 676.058516] x19: ffffffc87680c000 x18: 0000000000000000=20
[=A0 676.063820] x17: 0000000000000000 x16: 0000000000000000=20
[=A0 676.069123] x15: ffffffffffffffff x14: ffffff8008f09848=20
[=A0 676.074427] x13: ffffffc873ae391c x12: ffffffc873ae31a9=20
[=A0 676.079731] x11: 0101010101010101 x10: 0000000000000040=20
[=A0 676.085036] x9 : ffffff8008f9c8f8 x8 : 0000000000004501=20
[=A0 676.090339] x7 : ffffffc87680c000 x6 : ffffff800803b8fc=20
[=A0 676.095643] x5 : 0000000000000000 x4 : 0000000000000000=20
[=A0 676.100947] x3 : 0000000000004501 x2 : ffffffc83f794040=20
[=A0 676.106250] x1 : 0000000000000000 x0 : 0000000000000000=20
[=A0 676.111553] Call trace:
[=A0 676.113992]=A0 tpm_transmit+0x148/0x678
[=A0 676.117646]=A0 tpm_transmit_cmd+0x54/0xe8
[=A0 676.121475]=A0 tpm2_shutdown+0x88/0xa8
[=A0 676.125041]=A0 tpm_chip_unregister+0xc4/0xe0
[=A0 676.129130]=A0 tpm_tis_spi_remove+0x24/0x40
[=A0 676.133133]=A0 spi_drv_remove+0x34/0x58
[=A0 676.136788]=A0 device_release_driver_internal+0x1a4/0x238
[=A0 676.142005]=A0 device_release_driver+0x28/0x38
[=A0 676.146267]=A0 bus_remove_device+0xd4/0x148
[=A0 676.150269]=A0 device_del+0x158/0x388
[=A0 676.153749]=A0 device_unregister+0x24/0x78
[=A0 676.157664]=A0 spi_unregister_device+0x38/0x48
[=A0 676.161926]=A0 __unregister+0x20/0x30
[=A0 676.165407]=A0 device_for_each_child+0x58/0x88
[=A0 676.169669]=A0 spi_unregister_controller+0x44/0x128
[=A0 676.174364]=A0 dspi_remove+0x28/0x170
[=A0 676.177843]=A0 dspi_shutdown+0x20/0x30
[=A0 676.181410]=A0 platform_drv_shutdown+0x2c/0x38
[=A0 676.185671]=A0 device_shutdown+0x114/0x1f0
[=A0 676.189588]=A0 kernel_restart_prepare+0x44/0x50
[=A0 676.193936]=A0 kernel_restart+0x20/0x68
[=A0 676.197590]=A0 __se_sys_reboot+0x220/0x248
[=A0 676.201505]=A0 __arm64_sys_reboot+0x24/0x30
[=A0 676.205507]=A0 el0_svc_common+0xa4/0x198
[=A0 676.209248]=A0 el0_svc_handler+0x38/0x78
[=A0 676.212988]=A0 el0_svc+0x8/0xe8
[=A0 676.215949] Code: 72000400 b90073e0 54001360 f9435ec0 (f9402c02)=20
[=A0 676.222039] ---[ end trace 8d405bebaa8bfb3f ]---
[=A0 676.226710] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x0000000b
[=A0 676.226710]=20
[=A0 676.235839] Kernel Offset: disabled
[ =A0676.239319] CPU features: 0x0,20002004
[=A0 676.243058] Memory Limit: none
[=A0 676.246108] Rebooting in 90 seconds..
"

If needed, I can provide more information (u-boot logs and init code, devic=
e tree, u-boot and linux defconfig.)=20
Thanks for your support.

Mit freundlichen Gr=FC=DFen
Florian Mano=EBl

Siemens AG
Digital Industries
Process Automation
DI PA DCP R&D 2
=D6stliche Rheinbr=FCckenstr. 50
76187 Karlsruhe, Deutschland
Tel.: +49 721 667-20051
mailto:florian.manoel@siemens.com
https://siemens.com

Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hagemann Sn=
abe; Vorstand: Joe Kaeser, Vorsitzender; Roland Busch, Klaus Helmrich, Cedr=
ik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesell=
schaft: Berlin und M=FCnchen, Deutschland; Registergericht: Berlin-Charlott=
enburg, HRB 12300, M=FCnchen, HRB 6684; WEEE-Reg.-Nr. DE 23691322
